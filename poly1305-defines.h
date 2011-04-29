#if defined(_MSC_VER)
	#define COMPILER_MSVC
#endif
#if defined(__ICC)
	#define COMPILER_INTEL
#endif
#if defined(__GNUC__)
	#define COMPILER_GCC
#endif

#if defined(__64BIT__) || defined(__LP64__) || defined(_LP64) || defined(_M_IA64) || (_MIPS_SZLONG==64) || defined(__sparcv9)
	#define CPU_64BITS
#endif

#if defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__) || defined(_M_IX86) || defined(__X86__) || defined(_X86_) || defined(__I86__)
	#define CPU_X86
#endif

#if defined(__amd64__) || defined(__amd64) || defined(__x86_64__ ) || defined(_M_X64)
	#define CPU_X86_64
#endif

#define mul32x32_64(a,b) (((uint64_t)(a))*(b))

// stdint
#if defined(COMPILER_MSVC)
	#if !defined(_DEBUG)
		#undef mul32x32_64
		#include <intrin.h>
		#define mul32x32_64(a,b) __emulu(a,b)
	#endif
	#undef inline
	#define inline __forceinline
	typedef unsigned int uint32_t;
	typedef unsigned __int64 uint64_t;
#else
	#include <stdint.h>
	#include <sys/param.h>
	#undef inline
	#define inline __attribute__((always_inline))
#endif

// uint128_t
#if defined(CPU_64BITS)
	#if defined(COMPILER_MSVC)
		typedef unsigned __int128 uint128_t;
	#elif defined(COMPILER_GCC)
		typedef unsigned uint128_t __attribute__((mode(TI)));
	#else
		need 128bit define for this compiler
	#endif
#endif

// endian
#if ((defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && __BYTE_ORDER == __LITTLE_ENDIAN) || (defined(CPU_X86) || defined(CPU_X86_64)) || (defined(vax) || defined(MIPSEL)))
	static inline uint32_t U8TO32_LE(const unsigned char *p) { return *(const uint32_t *)p; }
	static inline void U32TO8_LE(unsigned char *p, const uint32_t v) { *(uint32_t *)p = v; }
	static inline uint64_t U8TO64_LE(const unsigned char *p) { return *(const uint64_t *)p; }
#else
	static inline uint32_t U8TO32_LE(const unsigned char *p) {
		return
		(((uint32_t)(p[0])      ) | 
		 ((uint32_t)(p[1]) <<  8) |
		 ((uint32_t)(p[2]) << 16) |
		 ((uint32_t)(p[3]) << 24));
	}

	static inline void U32TO8_LE(unsigned char *p, const uint32_t v) {
		p[0] = (unsigned char)(v      );
		p[1] = (unsigned char)(v >>  8);
		p[2] = (unsigned char)(v >> 16);
		p[3] = (unsigned char)(v >> 24);
	}

	static inline uint64_t U8TO64_LE(const unsigned char *p) {
		return
		(((uint64_t)((p)[0])      ) |
		 ((uint64_t)((p)[1]) <<  8) |
		 ((uint64_t)((p)[2]) << 16) |
		 ((uint64_t)((p)[3]) << 24) |
		 ((uint64_t)((p)[4]) << 32) |
		 ((uint64_t)((p)[5]) << 40) |
		 ((uint64_t)((p)[6]) << 48) |
		 ((uint64_t)((p)[7]) << 56));
	}
#endif

#define DONNA_INLINE inline
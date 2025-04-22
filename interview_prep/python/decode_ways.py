"""
Problem: Decode Ways
- Given a string containing only digits, return the number of ways to decode it.
- 'A' to 'Z' are mapped to '1' to '26'.

Input/Output/Constraints:
- Input: A non-empty string of digits (e.g., "226")
- Output: Total number of ways to decode the string (e.g., 3)
- Constraints:
 - '0' cannot be decoded alone (e.g., "06" is invalid)
 - Valid one-digit: '1' to '9'
 - Valid two-digit: '10' to '26'
       
Approach:
- Use Dynamic Programming (Bottom-Up)
- dp[i] = number of ways to decode the first i characters
- Two main cases:
 - One-digit decoding: if s[i-1] is in '1' to '9' → dp[i] += dp[i-1]
 - Two-digit decoding: if s[i-2:i] is in '10' to '26' → dp[i] += dp[i-2]

Time/Space Complexity:
- Time Complexity: O(n) — traverse the string once
- Space Complexity: O(n) — for dp array of size n+1

Edge Cases:
- Starts with '0': invalid, return 0
- Empty string: return 0
- s = "10" → only one valid way ("J")

Additional Notes:
One-digit decoding:
If the current character (i.e., s[i-1]) is between '1' and '9',
it can be decoded as a valid letter (e.g., '1' → 'A', '2' → 'B', ..., '9' → 'I').
So we add dp[i-1] to dp[i] because any valid decoding up to the previous character
can be extended by decoding this one digit.

Two-digit decoding:
If the two-character substring (i.e., s[i-2:i]) is between '10' and '26',
it can be decoded as a valid letter (e.g., '10' → 'J', ..., '26' → 'Z').
So we add dp[i-2] to dp[i] because any valid decoding up to two characters before
can be extended by decoding this two-digit number as one letter.
"""

class Solution:
    def numDecodings(self, s: str) -> int:
        # Edge case: starts with '0' or empty string
        if not s or s[0] == '0':
            return 0

        n = len(s)
        dp = [0] * (n + 1)
        dp[0] = 1  # base case: empty string
        dp[1] = 1  # first char already validated as non-zero

        for i in range(2, n + 1):
            one_digit = int(s[i - 1])        # single character
            two_digit = int(s[i - 2:i])      # two-character substring

            if 1 <= one_digit <= 9:
                dp[i] += dp[i - 1]

            if 10 <= two_digit <= 26:
                dp[i] += dp[i - 2]

        return dp[n]


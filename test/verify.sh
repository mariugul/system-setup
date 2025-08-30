#!/bin/bash
set -e

echo "🧪 Starting verification tests..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Helper function to run tests
test_command() {
    local test_name="$1"
    local command="$2"
    local expected_exit_code="${3:-0}"
    
    echo -n "Testing $test_name... "
    
    if eval "$command" >/dev/null 2>&1; then
        if [ $? -eq $expected_exit_code ]; then
            echo -e "${GREEN}✓ PASS${NC}"
            ((TESTS_PASSED++))
        else
            echo -e "${RED}✗ FAIL${NC} (unexpected exit code)"
            ((TESTS_FAILED++))
        fi
    else
        echo -e "${RED}✗ FAIL${NC}"
        ((TESTS_FAILED++))
    fi
}

# Test package installations
echo -e "\n${YELLOW}📦 Testing package installations...${NC}"
test_command "Git" "git --version"
test_command "Curl" "curl --version"
test_command "Wget" "wget --version"
test_command "GPG" "gpg --version"

# Test applications
echo -e "\n${YELLOW}🖥️  Testing applications...${NC}"
test_command "VS Code" "code --version"
test_command "Windsurf" "windsurf --version"
test_command "Slack" "slack --version"
test_command "Docker" "docker --version"
test_command "GitHub CLI" "gh --version"

# Test Python tools
echo -e "\n${YELLOW}🐍 Testing Python tools...${NC}"
test_command "Python3 venv" "python3 -m venv --help"
test_command "UV" "~/.cargo/bin/uv --version"

# Test user configurations
echo -e "\n${YELLOW}👤 Testing user configurations...${NC}"
test_command "Docker group membership" "groups | grep docker"
test_command "SSH key exists" "test -f ~/.ssh/id_ed25519"
test_command "Bash aliases" "test -f ~/.bash_aliases"

# Test services
echo -e "\n${YELLOW}🔧 Testing services...${NC}"
test_command "Docker service" "sudo systemctl is-active docker"

# Summary
echo -e "\n${YELLOW}📊 Test Summary:${NC}"
echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}🎉 All tests passed! Playbook is working correctly.${NC}"
    exit 0
else
    echo -e "\n${RED}❌ Some tests failed. Please check the playbook.${NC}"
    exit 1
fi

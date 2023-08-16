# tests/website.tests.ps1
Describe "Static Website Deployment" {
    It "Website content should be accessible" {
        $response = Invoke-WebRequest -Uri 'https://<cdn-endpoint-url>/index.html'
        $response.StatusCode | Should -BeExactly 200
        $response.Content | Should -Contain "Hello, Azure!"
    }
}

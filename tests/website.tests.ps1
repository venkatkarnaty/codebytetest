# tests/website.tests.ps1
Describe "Static Website Deployment" {
    $cdnEndpointUrl = "https://<cdn-endpoint-url>"

    It "Website content should be accessible" {
        $response = Invoke-WebRequest -Uri "$cdnEndpointUrl/index.html"
        $response.StatusCode | Should -BeExactly 200
        $response.Content | Should -Contain "Hello, Azure!"
    }

    It "CSS file should be accessible" {
        $response = Invoke-WebRequest -Uri "$cdnEndpointUrl/style.css"
        $response.StatusCode | Should -BeExactly 200
        $response.Content | Should -Contain "color: blue;"
    }

    It "JavaScript file should be accessible" {
        $response = Invoke-WebRequest -Uri "$cdnEndpointUrl/script.js"
        $response.StatusCode | Should -BeExactly 200
        $response.Content | Should -Contain "console.log('Script loaded.');"
    }

    It "404 page should be returned for non-existent page" {
        $response = Invoke-WebRequest -Uri "$cdnEndpointUrl/nonexistent.html"
        $response.StatusCode | Should -BeExactly 404
        $response.Content | Should -Contain "Page not found"
    }
}

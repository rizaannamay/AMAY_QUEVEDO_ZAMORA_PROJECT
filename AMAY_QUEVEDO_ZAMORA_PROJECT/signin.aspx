<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Account | AMAY QUEVEDO ZAMORA</title>
    <style>
        /* RESET & BASE - only design/format changes, no alterations to control IDs or labels text */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Inter', system-ui, -apple-system, BlinkMacSystemFont, 'Roboto', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 50%, #2e1065 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 24px;
            margin: 0;
        }

        /* modern card container - just format enhancement */
        .modern-card {
            background: rgba(255, 255, 255, 0.97);
            backdrop-filter: blur(0px);
            border-radius: 2rem;
            box-shadow: 0 25px 45px -12px rgba(0, 0, 0, 0.35), 0 8px 18px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 560px;
            transition: all 0.2s ease;
            overflow: hidden;
        }

        /* header decoration - keeps original labels untouched but adds visual style */
        .form-header-styling {
            background: linear-gradient(98deg, #4f46e5, #7c3aed, #a855f7);
            padding: 1.8rem 2rem;
            text-align: center;
        }

        .form-header-styling h1 {
            color: white;
            font-size: 1.9rem;
            font-weight: 700;
            letter-spacing: -0.3px;
            margin: 0;
            text-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .form-header-styling p {
            color: rgba(255,255,240,0.9);
            font-size: 0.9rem;
            margin-top: 8px;
        }

        /* content area padding */
        .form-content-padding {
            padding: 2rem 2rem 2rem 2rem;
        }

        /* field groups - improved spacing & alignment, but keeping original labels and controls */
        .field-group {
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
        }

        /* label row to preserve original label controls but make them look consistent */
        .label-row {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 6px;
        }

        /* original asp:Label elements get this style automatically via their parent context */
        /* but we keep them exactly as they are, just enhance spacing */
        
        /* all textboxes, dropdowns receive modern design (without changing IDs) */
        .modern-input {
            width: 100%;
            padding: 12px 16px;
            font-size: 15px;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            background-color: #fefefe;
            transition: all 0.2s;
            font-family: inherit;
            outline: none;
        }

        .modern-input:focus {
            border-color: #8b5cf6;
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2);
            background-color: #ffffff;
        }

        /* dropdown styling */
        select.modern-input {
            appearance: none;
            background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='18' height='18' viewBox='0 0 24 24' fill='none' stroke='%234b5563' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><polyline points='6 9 12 15 18 9'></polyline></svg>");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 16px;
            cursor: pointer;
        }

        /* original button remains, just redesign appearance */
        .btn-modern {
            background: linear-gradient(100deg, #4f46e5, #7c3aed);
            color: white;
            border: none;
            padding: 14px 20px;
            font-size: 1rem;
            font-weight: 700;
            border-radius: 40px;
            width: 100%;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin: 1rem 0 1.2rem 0;
            letter-spacing: 0.3px;
            font-family: inherit;
            box-shadow: 0 8px 14px -6px rgba(79, 70, 229, 0.4);
        }

        .btn-modern:hover {
            background: linear-gradient(100deg, #4338ca, #6d28d9);
            transform: translateY(-2px);
            box-shadow: 0 12px 20px -8px rgba(79, 70, 229, 0.5);
        }

        /* footer / login redirect */
        .footer-redirect {
            text-align: center;
            padding-top: 1rem;
            margin-top: 0.5rem;
            border-top: 1px solid #edf2f7;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            flex-wrap: wrap;
        }

        .login-link-custom {
            color: #6d28d9;
            font-weight: 700;
            text-decoration: none;
            border-bottom: 1.5px dashed #a78bfa;
            transition: all 0.2s;
            cursor: pointer;
            background: transparent;
            font-size: 0.95rem;
        }

        .login-link-custom:hover {
            color: #4c1d95;
            border-bottom-color: #4c1d95;
        }

        /* preserve original labels but improve spacing & font weight */
        asp\:Label, .original-label-style {
            font-weight: 600;
            color: #1f2937;
            font-size: 0.9rem;
            margin-right: 10px;
        }

        /* fix for original label alignment: make them look consistent */
        .label-wrapper {
            display: flex;
            align-items: center;
            margin-bottom: 6px;
        }

        /* each control row - we want to wrap original controls but keep exact IDs */
        .control-row {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        /* special handling for the inline "role:" text that appears before dropdown (original plain text) */
        .role-plain-text {
            font-weight: 600;
            color: #1f2937;
            font-size: 0.9rem;
            margin-bottom: 6px;
            display: block;
        }

        /* ensure drop-down list gets modern style */
        select#DropDownList1 {
            width: 100%;
        }

        /* all textboxes and dropdown via class also IDs remain untouched */
        input[type="text"], input[type="password"], input[type="email"], select {
            width: 100%;
        }

        /* maintain responsive design */
        @media (max-width: 550px) {
            .form-content-padding {
                padding: 1.5rem;
            }
            .form-header-styling h1 {
                font-size: 1.5rem;
            }
        }

        /* small spacing adjustments for br tags? we keep them but design overrides natural flow */
        .spacer-clean {
            line-height: normal;
        }
        
        /* ensure original button text unchanged */
        #Button1 {
            background: linear-gradient(100deg, #4f46e5, #7c3aed);
            color: white;
            border: none;
            padding: 14px 20px;
            font-size: 1rem;
            font-weight: 700;
            border-radius: 40px;
            width: 100%;
            cursor: pointer;
            transition: all 0.2s;
            margin-top: 12px;
            margin-bottom: 20px;
            font-family: inherit;
        }
        
        #Button1:hover {
            background: linear-gradient(100deg, #4338ca, #6d28d9);
            transform: translateY(-2px);
            box-shadow: 0 10px 18px -6px rgba(79, 70, 229, 0.5);
        }
        
        /* all original labels get consistent styling */
        #Label2, #Label3, #Label4, #Label5, #Label6, #Label7 {
            font-weight: 600;
            color: #1e293b;
            font-size: 0.9rem;
            display: inline-block;
        }
        
        /* wrap inputs nicely */
        .input-wrapper {
            margin-top: 4px;
            width: 100%;
        }
        
        /* design for textboxes: txtEmail, txtUsername, txtPassword, txtConfirmPassword */
        #txtEmail, #txtUsername, #txtPassword, #txtConfirmPassword {
            width: 100%;
            padding: 12px 16px;
            font-size: 15px;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            background: #fafcff;
            transition: 0.2s;
            font-family: inherit;
            box-sizing: border-box;
        }
        
        #txtEmail:focus, #txtUsername:focus, #txtPassword:focus, #txtConfirmPassword:focus, #DropDownList1:focus {
            border-color: #8b5cf6;
            outline: none;
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2);
            background: white;
        }
        
        #DropDownList1 {
            width: 100%;
            padding: 12px 16px;
            font-size: 15px;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            background: #fafcff;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='18' height='18' viewBox='0 0 24 24' fill='none' stroke='%234b5563' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><polyline points='6 9 12 15 18 9'></polyline></svg>");
            background-repeat: no-repeat;
            background-position: right 16px center;
        }
        
        /* organize sections: each field group with proper spacing */
        .form-group {
            margin-bottom: 1.4rem;
        }
        
        .inline-label-row {
            display: flex;
            align-items: center;
            margin-bottom: 6px;
        }
        
        /* keep original line breaks but modern spacing */
        br {
            display: none;  /* removing original <br> tags to avoid extra gaps, but we'll add spacing via CSS margin */
        }
        
        /* we'll keep the exact original elements, just override layout by making form display block */
        #form1 {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }
        
        /* original labels and text appear inline but we restructure via grid/flex but keep same hierarchy */
        /* to avoid breaking original functionality we do not reorder server controls, just wrap them elegantly */
        
        /* redesign using css grid to wrap each field, but keep original order */
        .design-wrapper {
            display: flex;
            flex-direction: column;
        }
        
        /* each original block (label + control) will be wrapped with div for spacing but not removing IDs */
        .field-card {
            margin-bottom: 1.5rem;
        }
        
        /* role plain text styling - "role:" appears as plain text before dropdown, we preserve exactly */
        .role-static-text {
            font-weight: 600;
            color: #1f2937;
            font-size: 0.9rem;
            margin-bottom: 6px;
            display: block;
        }
        
        /* login redirect link: keep original label7 text but add clickable link after */
        .redirect-action {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin-left: 4px;
        }
        
        /* ensure the original Label7 is visible and not altered */
        #Label7 {
            margin-right: 4px;
        }
        
        /* additional modern micro-interactions */
        .attribution-note {
            font-size: 0.7rem;
            text-align: center;
            color: #94a3b8;
            margin-top: 1rem;
            padding-top: 0.5rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        -->
        <div class="modern-card">
            <div class="form-header-styling">
                <h1>✨ Welcome ✨</h1>
                <p>Join our community today</p>
            </div>
            <div class="form-content-padding">
                <div class="field-card">
                    <asp:Label ID="Label2" runat="server" Text="Create Account" style="font-size: 1.6rem; font-weight: 800; background: linear-gradient(135deg, #4f46e5, #c084fc); -webkit-background-clip: text; background-clip: text; color: transparent; display: block; text-align: center; margin-bottom: 0.75rem;"></asp:Label>
                </div>
                
                <!-- email field: Label3 + txtEmail -->
                <div class="field-card">
                    <div class="inline-label-row">
                        <asp:Label ID="Label3" runat="server" Text="email"></asp:Label>
                    </div>
                    <div class="input-wrapper">
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                    </div>
                </div>
                
                <!-- role: plain text "role:" and DropDownList1 (unchanged) -->
                <div class="field-card">
                    <div class="role-static-text">role:</div>
                    <asp:DropDownList ID="DropDownList1" runat="server">
                        <asp:ListItem>Student</asp:ListItem>
                        <asp:ListItem>Admin</asp:ListItem>
                    </asp:DropDownList>
                </div>
                
                <!-- Username field: Label4 + txtUsername -->
                <div class="field-card">
                    <div class="inline-label-row">
                        <asp:Label ID="Label4" runat="server" Text="Username"></asp:Label>
                    </div>
                    <div class="input-wrapper">
                        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                    </div>
                </div>
                
                <!-- password field: Label5 + txtPassword -->
                <div class="field-card">
                    <div class="inline-label-row">
                        <asp:Label ID="Label5" runat="server" Text="password"></asp:Label>
                    </div>
                    <div class="input-wrapper">
                        <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                    </div>
                </div>
                
                <!-- confirm password field: Label6 + txtConfirmPassword (original label text "comfirm password" - typo preserved exactly) -->
                <div class="field-card">
                    <div class="inline-label-row">
                        <asp:Label ID="Label6" runat="server" Text="comfirm password"></asp:Label>
                    </div>
                    <div class="input-wrapper">
                        <asp:TextBox ID="txtConfirmPassword" runat="server"></asp:TextBox>
                    </div>
                </div>
                
                <!-- Button1 with original text "Sign In" unchanged -->
                <div class="field-card" style="margin-top: 0.5rem;">
                    <asp:Button ID="Button1" runat="server" Text="Sign In" />
                </div>
                
                <!-- footer area: Label7 text "Already have account? " plus a functional login link (doesn't alter Label7) -->
                <div class="footer-redirect">
                    <asp:Label ID="Label7" runat="server" Text="Already have account? "></asp:Label>
                    <a id="loginRedirectBtn" class="login-link-custom">Log in →</a>
                </div>
                <!-- original comment from code: "// make the user go to log in form" is implemented below via JS, design preserved -->
            </div>
        </div>
        
        <!-- JavaScript to handle redirection to login form (preserves original requirement without modifying server controls) -->
        <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function () {
                var loginLink = document.getElementById("loginRedirectBtn");
                if (loginLink) {
                    loginLink.addEventListener("click", function (e) {
                        e.preventDefault();
                        // redirect to login page (adjust path to your login form, e.g., "login.aspx" or "signin.aspx?mode=login")
                        // as per requirement "make the user go to log in form"
                        window.location.href = "login.aspx";
                    });
                }

                // Optional: add modern client-side hint for password matching but does not change any server behavior
                var pwd = document.getElementById("<%= txtPassword.ClientID %>");
                var confirmPwd = document.getElementById("<%= txtConfirmPassword.ClientID %>");
                if (pwd && confirmPwd) {
                    function checkMatch() {
                        if (pwd.value !== confirmPwd.value && confirmPwd.value.length > 0) {
                            confirmPwd.style.borderColor = "#f87171";
                            confirmPwd.style.boxShadow = "0 0 0 2px rgba(248,113,113,0.2)";
                        } else if (confirmPwd.value.length > 0) {
                            confirmPwd.style.borderColor = "#4ade80";
                            confirmPwd.style.boxShadow = "0 0 0 2px rgba(74,222,128,0.2)";
                        } else {
                            confirmPwd.style.borderColor = "#e2e8f0";
                            confirmPwd.style.boxShadow = "none";
                        }
                    }
                    pwd.addEventListener("keyup", checkMatch);
                    confirmPwd.addEventListener("keyup", checkMatch);
                }
            });
        </script>
    </form>
</body>
</html>
using System;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    /// <summary>
    /// Sends transactional emails via Gmail SMTP.
    /// Credentials are read from Web.config appSettings:
    ///   Email.From, Email.Password
    /// </summary>
    public static class EmailHelper
    {
        private static readonly string FromAddress = ConfigurationManager.AppSettings["Email.From"]     ?? "";
        private static readonly string FromPassword = ConfigurationManager.AppSettings["Email.Password"] ?? "";
        private static readonly string FromName     = ConfigurationManager.AppSettings["Email.DisplayName"] ?? "Campus Announcement Portal";

        // ── Announcement approved / rejected ─────────────────────────
        public static void SendAnnouncementDecision(
            string toEmail,
            string toName,
            string announcementTitle,
            bool   approved,
            string rejectionReason = "")
        {
            if (string.IsNullOrWhiteSpace(toEmail)) return;

            string subject, body;

            if (approved)
            {
                subject = "Your Announcement Has Been Approved";
                body = $@"
<div style='font-family:Segoe UI,Arial,sans-serif;max-width:600px;margin:0 auto;'>
  <div style='background:#c9920a;padding:24px 32px;border-radius:12px 12px 0 0;'>
    <h2 style='color:#fff;margin:0;'>Campus Announcement Portal</h2>
  </div>
  <div style='background:#ffffff;padding:32px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;'>
    <p style='font-size:16px;color:#1a2a3a;'>Hi <strong>{HtmlEncode(toName)}</strong>,</p>
    <p style='font-size:15px;color:#374151;'>Great news! Your announcement has been <strong style='color:#059669;'>approved</strong> and is now live on the portal.</p>
    <div style='background:#f0fdf4;border-left:4px solid #059669;padding:14px 18px;border-radius:6px;margin:20px 0;'>
      <p style='margin:0;font-size:14px;color:#065f46;'><strong>Announcement:</strong> {HtmlEncode(announcementTitle)}</p>
    </div>
    <p style='font-size:14px;color:#6b7280;'>Students and teachers can now view your announcement on the Campus Announcement Portal.</p>
    <hr style='border:none;border-top:1px solid #e5e7eb;margin:24px 0;'/>
    <p style='font-size:12px;color:#9ca3af;'>This is an automated message from the Campus Announcement Portal. Please do not reply to this email.</p>
  </div>
</div>";
            }
            else
            {
                subject = "Your Announcement Was Not Approved";
                string reasonHtml = string.IsNullOrWhiteSpace(rejectionReason)
                    ? ""
                    : $@"<div style='background:#fef2f2;border-left:4px solid #dc2626;padding:14px 18px;border-radius:6px;margin:16px 0;'>
                           <p style='margin:0;font-size:14px;color:#991b1b;'><strong>Reason:</strong> {HtmlEncode(rejectionReason)}</p>
                         </div>";

                body = $@"
<div style='font-family:Segoe UI,Arial,sans-serif;max-width:600px;margin:0 auto;'>
  <div style='background:#c9920a;padding:24px 32px;border-radius:12px 12px 0 0;'>
    <h2 style='color:#fff;margin:0;'>Campus Announcement Portal</h2>
  </div>
  <div style='background:#ffffff;padding:32px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;'>
    <p style='font-size:16px;color:#1a2a3a;'>Hi <strong>{HtmlEncode(toName)}</strong>,</p>
    <p style='font-size:15px;color:#374151;'>Unfortunately, your announcement was <strong style='color:#dc2626;'>not approved</strong> by the administrator.</p>
    <div style='background:#fef2f2;border-left:4px solid #dc2626;padding:14px 18px;border-radius:6px;margin:20px 0;'>
      <p style='margin:0;font-size:14px;color:#991b1b;'><strong>Announcement:</strong> {HtmlEncode(announcementTitle)}</p>
    </div>
    {reasonHtml}
    <p style='font-size:14px;color:#6b7280;'>If you have questions, please contact the portal administrator.</p>
    <hr style='border:none;border-top:1px solid #e5e7eb;margin:24px 0;'/>
    <p style='font-size:12px;color:#9ca3af;'>This is an automated message from the Campus Announcement Portal. Please do not reply to this email.</p>
  </div>
</div>";
            }

            Send(toEmail, subject, body);
        }

        // ── Teacher account approved / rejected ──────────────────────
        public static void SendAccountDecision(
            string toEmail,
            string toName,
            bool   approved)
        {
            if (string.IsNullOrWhiteSpace(toEmail)) return;

            string subject, body;

            if (approved)
            {
                subject = "Your Teacher Account Has Been Approved";
                body = $@"
<div style='font-family:Segoe UI,Arial,sans-serif;max-width:600px;margin:0 auto;'>
  <div style='background:#c9920a;padding:24px 32px;border-radius:12px 12px 0 0;'>
    <h2 style='color:#fff;margin:0;'>Campus Announcement Portal</h2>
  </div>
  <div style='background:#ffffff;padding:32px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;'>
    <p style='font-size:16px;color:#1a2a3a;'>Hi <strong>{HtmlEncode(toName)}</strong>,</p>
    <p style='font-size:15px;color:#374151;'>Your teacher account has been <strong style='color:#059669;'>approved</strong>! You can now log in to the Campus Announcement Portal.</p>
    <div style='background:#f0fdf4;border-left:4px solid #059669;padding:14px 18px;border-radius:6px;margin:20px 0;'>
      <p style='margin:0;font-size:14px;color:#065f46;'>You can now post announcements, manage your calendar, and interact with students.</p>
    </div>
    <p style='font-size:14px;color:#6b7280;'>Visit the portal and log in with your registered credentials to get started.</p>
    <hr style='border:none;border-top:1px solid #e5e7eb;margin:24px 0;'/>
    <p style='font-size:12px;color:#9ca3af;'>This is an automated message from the Campus Announcement Portal. Please do not reply to this email.</p>
  </div>
</div>";
            }
            else
            {
                subject = "Your Teacher Account Registration Was Not Approved";
                body = $@"
<div style='font-family:Segoe UI,Arial,sans-serif;max-width:600px;margin:0 auto;'>
  <div style='background:#c9920a;padding:24px 32px;border-radius:12px 12px 0 0;'>
    <h2 style='color:#fff;margin:0;'>Campus Announcement Portal</h2>
  </div>
  <div style='background:#ffffff;padding:32px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;'>
    <p style='font-size:16px;color:#1a2a3a;'>Hi <strong>{HtmlEncode(toName)}</strong>,</p>
    <p style='font-size:15px;color:#374151;'>We regret to inform you that your teacher account registration has been <strong style='color:#dc2626;'>declined</strong>.</p>
    <p style='font-size:14px;color:#6b7280;'>If you believe this is a mistake or need further assistance, please contact the portal administrator.</p>
    <hr style='border:none;border-top:1px solid #e5e7eb;margin:24px 0;'/>
    <p style='font-size:12px;color:#9ca3af;'>This is an automated message from the Campus Announcement Portal. Please do not reply to this email.</p>
  </div>
</div>";
            }

            Send(toEmail, subject, body);
        }

        // ── Calendar event reminder ──────────────────────────────────
        public static void SendCalendarReminder(
            string    toEmail,
            string    toName,
            string    eventTitle,
            DateTime  eventDate,
            TimeSpan? eventTime,
            string    eventType,
            bool      isPublic)
        {
            if (string.IsNullOrWhiteSpace(toEmail)) return;

            string dateStr = eventDate.ToString("dddd, MMMM d, yyyy");
            string timeStr = eventTime.HasValue
                ? DateTime.Today.Add(eventTime.Value).ToString("h:mm tt")
                : "";
            string timeHtml = string.IsNullOrEmpty(timeStr)
                ? ""
                : $"<p style='margin:4px 0 0;font-size:13px;color:#6b7280;'>Time: {timeStr}</p>";

            string scope = isPublic ? "Public Event" : "Personal Reminder";
            string subject = $"Reminder: \"{eventTitle}\" is Tomorrow";

            string body = $@"
<div style='font-family:Segoe UI,Arial,sans-serif;max-width:600px;margin:0 auto;'>
  <div style='background:#c9920a;padding:24px 32px;border-radius:12px 12px 0 0;'>
    <h2 style='color:#fff;margin:0;'>Campus Announcement Portal</h2>
  </div>
  <div style='background:#ffffff;padding:32px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;'>
    <p style='font-size:16px;color:#1a2a3a;'>Hi <strong>{HtmlEncode(toName)}</strong>,</p>
    <p style='font-size:15px;color:#374151;'>This is a reminder that the following event is scheduled for <strong>tomorrow</strong>:</p>
    <div style='background:#fef9e7;border-left:4px solid #c9920a;padding:16px 20px;border-radius:8px;margin:20px 0;'>
      <p style='margin:0;font-size:16px;font-weight:700;color:#1a2a3a;'>{HtmlEncode(eventTitle)}</p>
      <p style='margin:6px 0 0;font-size:13px;color:#6b7280;'>Date: {dateStr}</p>
      {timeHtml}
      <p style='margin:6px 0 0;font-size:12px;color:#9ca3af;'>{HtmlEncode(eventType)} · {scope}</p>
    </div>
    <p style='font-size:14px;color:#6b7280;'>Make sure you are prepared and don't miss it!</p>
    <hr style='border:none;border-top:1px solid #e5e7eb;margin:24px 0;'/>
    <p style='font-size:12px;color:#9ca3af;'>This is an automated reminder from the Campus Announcement Portal. Please do not reply to this email.</p>
  </div>
</div>";

            Send(toEmail, subject, body);
        }

        // ── Calendar 5-minute reminder ───────────────────────────────
        public static void SendCalendarReminder5Min(
            string   toEmail,
            string   toName,
            string   eventTitle,
            DateTime eventDate,
            TimeSpan eventTime,
            string   eventType,
            bool     isPublic)
        {
            if (string.IsNullOrWhiteSpace(toEmail)) return;

            string dateStr = eventDate.ToString("dddd, MMMM d, yyyy");
            string timeStr = DateTime.Today.Add(eventTime).ToString("h:mm tt");
            string scope   = isPublic ? "Public Event" : "Personal Reminder";
            string subject = $"Starting in 5 minutes: \"{HtmlEncode(eventTitle)}\"";

            string body = $@"
<div style='font-family:Segoe UI,Arial,sans-serif;max-width:600px;margin:0 auto;'>
  <div style='background:#c9920a;padding:24px 32px;border-radius:12px 12px 0 0;'>
    <h2 style='color:#fff;margin:0;'>Campus Announcement Portal</h2>
  </div>
  <div style='background:#ffffff;padding:32px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;'>
    <p style='font-size:16px;color:#1a2a3a;'>Hi <strong>{HtmlEncode(toName)}</strong>,</p>
    <p style='font-size:15px;color:#374151;'>This is your <strong style='color:#dc2626;'>5-minute reminder</strong> — the following event is starting very soon:</p>
    <div style='background:#fff7ed;border-left:4px solid #ea580c;padding:16px 20px;border-radius:8px;margin:20px 0;'>
      <p style='margin:0;font-size:18px;font-weight:800;color:#1a2a3a;'>{HtmlEncode(eventTitle)}</p>
      <p style='margin:8px 0 0;font-size:14px;color:#6b7280;'>Date: {dateStr}</p>
      <p style='margin:4px 0 0;font-size:14px;color:#ea580c;font-weight:700;'>Time: {timeStr} — Starting in 5 minutes!</p>
      <p style='margin:6px 0 0;font-size:12px;color:#9ca3af;'>{HtmlEncode(eventType)} · {scope}</p>
    </div>
    <p style='font-size:14px;color:#6b7280;'>Please get ready now!</p>
    <hr style='border:none;border-top:1px solid #e5e7eb;margin:24px 0;'/>
    <p style='font-size:12px;color:#9ca3af;'>This is an automated reminder from the Campus Announcement Portal. Please do not reply to this email.</p>
  </div>
</div>";

            Send(toEmail, subject, body);
        }

        // ── Core send method ─────────────────────────────────────────
        private static void Send(string toEmail, string subject, string htmlBody)
        {
            if (string.IsNullOrWhiteSpace(FromAddress) || string.IsNullOrWhiteSpace(FromPassword))
                return; // Email not configured — skip silently

            try
            {
                using (var msg = new MailMessage())
                {
                    msg.From       = new MailAddress(FromAddress, FromName);
                    msg.To.Add(new MailAddress(toEmail));
                    msg.Subject    = subject;
                    msg.Body       = htmlBody;
                    msg.IsBodyHtml = true;

                    using (var smtp = new SmtpClient("smtp.gmail.com", 587))
                    {
                        smtp.EnableSsl             = true;
                        smtp.DeliveryMethod        = SmtpDeliveryMethod.Network;
                        smtp.UseDefaultCredentials = false;
                        smtp.Credentials           = new NetworkCredential(FromAddress, FromPassword);
                        smtp.Timeout               = 15000;
                        smtp.Send(msg);
                    }
                }
            }
            catch
            {
                // Email failure must never break the main request — swallow silently
            }
        }

        private static string HtmlEncode(string s)
        {
            return System.Web.HttpUtility.HtmlEncode(s ?? "");
        }
    }
}

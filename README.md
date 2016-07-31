ct_advisor_int
==========

ct_advisor is a proactive alerting tool for [Google's Certificate Transparency](https://www.certificate-transparency.org/).

Google offers a number of great options for an administrator to utilise this feature. Unfortunately being an early adopter, particularly if you run Windows servers or run SSL on appliances, makes it difficult to take advantage of this service.

As an alternative option, this service continually polls the CT log, and will trigger alerts if a certificate is ever registered for your domain, by any CA in the CT program. This can be used to identify fraudulent certificates.

This image this ct_advisor in action:

![CT Advisor Email](https://lolware.net/ct_advisor_email.jpg)

ct_advisor_int is the front-end interface, which manages signups and unubscriptions, to the database shared with the backup.

[The backend source code can be found here](https://raw.githubusercontent.com/technion/ct_advisor)

This service is running live and, unless you are interested in development, users are encouraged to use my existing service in place of running it themselves.

Setup
-----
The following items must configured in .env:

```
DEV_DB_PASS=xx
TEST_DB_PASS=xx
SMTP_HOST=xx
SMTP_USER=xx
SMTP_PASS=xx
RECAPTCHA_PUBLIC_KEY=xx
RECAPTCHA_PRIVATE_KEY=xx
```

Management
----------
Start: 
```
RAILS_ENV=production puma -C config/puma/production.rb
```
Uninterupted restart:
```
kill -s SIGUSR2 `cat tmp/pids/puma.pid`
```

Contributing
------------

* In line with the above, potential contributors should be aware I am unlikely to merge and changes relating to features that I won't be using.
* Complex functions must include tests
* Leave your politics at the door

#!/usr/bin/env perl
#***************************************************************************
#                                  _   _ ____  _
#  Project                     ___| | | |  _ \| |
#                             / __| | | | |_) | |
#                            | (__| |_| |  _ <| |___
#                             \___|\___/|_| \_\_____|
#
# Copyright (C) 2017 - 2020, Daniel Stenberg, <daniel@haxx.se>, et al.
#
# This software is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at https://curl.se/docs/copyright.html.
#
# You may opt to use, copy, modify, merge, publish, distribute and/or sell
# copies of the Software, and permit persons to whom the Software is
# furnished to do so, under the terms of the COPYING file.
#
# This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
# KIND, either express or implied.
#
###########################################################################

# Usage:
#   perl mk-lib1521.pl < ../../include/curl/curl.h > lib1521.c

# minimum and maximum long signed values
my $minlong = "LONG_MIN";
my $maxlong = "LONG_MAX";
# maximum long unsigned value
my $maxulong = "ULONG_MAX";

print <<HEADER
/***************************************************************************
 *                                  _   _ ____  _
 *  Project                     ___| | | |  _ \\| |
 *                             / __| | | | |_) | |
 *                            | (__| |_| |  _ <| |___
 *                             \\___|\\___/|_| \\_\\_____|
 *
 * Copyright (C) 2017, Daniel Stenberg, <daniel@haxx.se>, et al.
 *
 * This software is licensed as described in the file COPYING, which
 * you should have received as part of this distribution. The terms
 * are also available at https://curl.se/docs/copyright.html.
 *
 * You may opt to use, copy, modify, merge, publish, distribute and/or sell
 * copies of the Software, and permit persons to whom the Software is
 * furnished to do so, under the terms of the COPYING file.
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
 * KIND, either express or implied.
 *
 ***************************************************************************/
#include "test.h"
#include "memdebug.h"
#include <limits.h>

/* This source code is generated by mk-lib1521.pl ! */

struct data {
    char *blaha;
};

#define LO $minlong
#define HI $maxlong
#define OFF_LO (curl_off_t) LO
#define OFF_HI (curl_off_t) $maxulong
#define OFF_NO (curl_off_t) 0

/* Unexpected error.
    CURLE_NOT_BUILT_IN   - means disabled at build
    CURLE_UNKNOWN_OPTION - means no such option (anymore?)
    CURLE_SSL_ENGINE_NOTFOUND - set unknown ssl engine
    CURLE_UNSUPPORTED_PROTOCOL - set bad HTTP version
    CURLE_BAD_FUNCTION_ARGUMENT - unsupported value
   */
#define UNEX(x) ((x) && \\
                 ((x) != CURLE_NOT_BUILT_IN) && \\
                 ((x) != CURLE_UNKNOWN_OPTION) && \\
                 ((x) != CURLE_SSL_ENGINE_NOTFOUND) && \\
                 ((x) != CURLE_UNSUPPORTED_PROTOCOL) && \\
                 ((x) != CURLE_BAD_FUNCTION_ARGUMENT) )

static size_t writecb(char *buffer, size_t size, size_t nitems,
                      void *outstream)
{
  (void)buffer;
  (void)size;
  (void)nitems;
  (void)outstream;
  return 0;
}

static size_t readcb(char *buffer,
              size_t size,
              size_t nitems,
              void *instream)
{
  (void)buffer;
  (void)size;
  (void)nitems;
  (void)instream;
  return 0;
}

static int err(const char *name, CURLcode val, int lineno)
{
  printf("CURLOPT_%s returned %d, \\"%s\\" on line %d\\n",
         name, val, curl_easy_strerror(val), lineno);
  return (int)val;
}

static int geterr(const char *name, CURLcode val, int lineno)
{
  printf("CURLINFO_%s returned %d, \\"%s\\" on line %d\\n",
         name, val, curl_easy_strerror(val), lineno);
  return (int)val;
}

static curl_progress_callback progresscb;
static curl_write_callback headercb;
static curl_debug_callback debugcb;
static curl_trailer_callback trailercb;
static curl_ssl_ctx_callback ssl_ctx_cb;
static curl_ioctl_callback ioctlcb;
static curl_sockopt_callback sockoptcb;
static curl_opensocket_callback opensocketcb;
static curl_seek_callback seekcb;
static curl_sshkeycallback ssh_keycb;
static curl_chunk_bgn_callback chunk_bgn_cb;
static curl_chunk_end_callback chunk_end_cb;
static curl_fnmatch_callback fnmatch_cb;
static curl_closesocket_callback closesocketcb;
static curl_xferinfo_callback xferinfocb;
static curl_hstsread_callback hstsreadcb;
static curl_hstswrite_callback hstswritecb;
static curl_resolver_start_callback resolver_start_cb;
static curl_prereq_callback prereqcb;

int test(char *URL)
{
  CURL *curl = NULL;
  CURL *dep = NULL;
  CURLSH *share = NULL;
  char errorbuffer[CURL_ERROR_SIZE];
  void *conv_from_network_cb = NULL;
  void *conv_to_network_cb = NULL;
  void *conv_from_utf8_cb = NULL;
  void *interleavecb = NULL;
  char *stringpointerextra = (char *)"moooo";
  struct curl_slist *slist = NULL;
  struct curl_httppost *httppost = NULL;
  curl_mime *mimepost = NULL;
  FILE *stream = stderr;
  struct data object;
  char *charp;
  long val;
  curl_off_t oval;
  double dval;
  curl_socket_t sockfd;
  struct curl_certinfo *certinfo;
  struct curl_tlssessioninfo *tlssession;
  struct curl_blob blob = { (void *)"silly", 5, 0};
  CURLcode res = CURLE_OK;
  (void)URL; /* not used */
  global_init(CURL_GLOBAL_ALL);
  easy_init(dep);
  easy_init(curl);
  share = curl_share_init();
  if(!share) {
    res = CURLE_OUT_OF_MEMORY;
    goto test_cleanup;
  }

HEADER
    ;

while(<STDIN>) {
    if($_ =~ /^  CURLOPT\(([^ ]*), ([^ ]*), (\d*)\)/) {
        my ($name, $type, $val)=($1, $2, $3);
        my $w="  ";
        my $pref = "${w}res = curl_easy_setopt(curl, $name,";
        my $i = ' ' x (length($w) + 23);
        my $check = "  if(UNEX(res)) {\n    err(\"$name\", res, __LINE__);\n    goto test_cleanup;\n  }\n";
        if($type eq "CURLOPTTYPE_STRINGPOINT") {
            print "${pref} \"string\");\n$check";
            print "${pref} NULL);\n$check";
        }
        elsif(($type eq "CURLOPTTYPE_LONG") ||
              ($type eq "CURLOPTTYPE_VALUES")) {
            print "${pref} 0L);\n$check";
            print "${pref} 22L);\n$check";
            print "${pref} LO);\n$check";
            print "${pref} HI);\n$check";
        }
        elsif(($type eq "CURLOPTTYPE_OBJECTPOINT") ||
              ($type eq "CURLOPTTYPE_CBPOINT")) {
            if($name =~ /DEPENDS/) {
              print "${pref} dep);\n$check";
            }
            elsif($name =~ "SHARE") {
              print "${pref} share);\n$check";
            }
            elsif($name eq "CURLOPT_ERRORBUFFER") {
              print "${pref} errorbuffer);\n$check";
            }
            elsif(($name eq "CURLOPT_POSTFIELDS") ||
                  ($name eq "CURLOPT_COPYPOSTFIELDS")) {
                # set size to zero to avoid it being "illegal"
                print "  (void)curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, 0);\n";
                print "${pref} stringpointerextra);\n$check";
            }
            elsif($name eq "CURLOPT_HTTPPOST") {
              print "${pref} httppost);\n$check";
            }
            elsif($name eq "CURLOPT_MIMEPOST") {
              print "${pref} mimepost);\n$check";
            }
            elsif($name eq "CURLOPT_STDERR") {
              print "${pref} stream);\n$check";
            }
            else {
              print "${pref} &object);\n$check";
            }
            print "${pref} NULL);\n$check";
        }
        elsif($type eq "CURLOPTTYPE_SLISTPOINT") {
            print "${pref} slist);\n$check";
        }
        elsif($type eq "CURLOPTTYPE_FUNCTIONPOINT") {
            if($name =~ /([^ ]*)FUNCTION/) {
                my $l=lc($1);
                $l =~ s/^curlopt_//;
                print "${pref}\n$i${l}cb);\n$check";
            }
            else {
                print "${pref} &func);\n$check";
            }
            print "${pref} NULL);\n$check";
        }
        elsif($type eq "CURLOPTTYPE_OFF_T") {
            # play conservative to work with 32bit curl_off_t
            print "${pref} OFF_NO);\n$check";
            print "${pref} OFF_HI);\n$check";
            print "${pref} OFF_LO);\n$check";
        }
        elsif($type eq "CURLOPTTYPE_BLOB") {
            print "${pref} &blob);\n$check";
        }
        else {
            print STDERR "\nUnknown type: $type\n";
            exit 22; # exit to make this noticed!
        }
    }
    elsif($_ =~ /^  CURLINFO_NONE/) {
       $infomode = 1;
    }
    elsif($infomode &&
          ($_ =~ /^  CURLINFO_([^ ]*) *= *CURLINFO_([^ ]*)/)) {
       my ($info, $type)=($1, $2);
       my $c = "  res = curl_easy_getinfo(curl, CURLINFO_$info,";
       my $check = "  if(UNEX(res)) {\n    geterr(\"$info\", res, __LINE__);\n    goto test_cleanup;\n  }\n";
       if($type eq "STRING") {
         print "$c &charp);\n$check";
       }
       elsif($type eq "LONG") {
         print "$c &val);\n$check";
       }
       elsif($type eq "OFF_T") {
         print "$c &oval);\n$check";
       }
       elsif($type eq "DOUBLE") {
         print "$c &dval);\n$check";
       }
       elsif($type eq "SLIST") {
         print "$c &slist);\n$check";
         print "  if(slist)\n    curl_slist_free_all(slist);\n";
       }
       elsif($type eq "SOCKET") {
         print "$c &sockfd);\n$check";
       }
       elsif($type eq "PTR") {
         if($info eq "CERTINFO") {
            print "$c &certinfo);\n$check";
         }
         elsif(($info eq "TLS_SESSION") ||
               ($info eq "TLS_SSL_PTR")) {
            print "$c &tlssession);\n$check";
         }
         else {
            print STDERR "$info/$type is unsupported\n";
         }
       }
       else {
         print STDERR "$type is unsupported\n";
       }
    }
}


print <<FOOTER
  curl_easy_setopt(curl, (CURLoption)1, 0);
  res = CURLE_OK;
test_cleanup:
  curl_easy_cleanup(curl);
  curl_easy_cleanup(dep);
  curl_share_cleanup(share);
  curl_global_cleanup();

  return (int)res;
}
FOOTER
    ;

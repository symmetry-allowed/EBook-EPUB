# Copyright (c) 2009 Oleksandr Tymoshenko <gonzo@bluezbox.com>
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

package EPUB::Package;
use Moose;

use EPUB::Package::Metadata;
use EPUB::Package::Manifest;
use EPUB::Package::Guide;
use EPUB::Package::Spine;

has metadata    => (
    isa     => 'Object', 
    is      => 'ro',
    default => sub { EPUB::Package::Metadata->new() }
);

has manifest    => (
    isa     => 'Object', 
    is      => 'ro',
    default => sub { EPUB::Package::Manifest->new() }
);

has spine       => (
    isa     => 'Object', 
    is      => 'ro',
    default => sub { EPUB::Package::Spine->new() }
);

has guide       => (
    isa     => 'Object', 
    is      => 'ro',
    default => sub { EPUB::Package::Guide->new() }
);

has uid         => (
    isa     => 'Str',
    is      => 'rw',
);

sub encode
{
    my ($self, $writer) = @_;

    $writer->startTag("package", 
        xmlns               => "http://www.idpf.org/2007/opf",
        version             => "2.0",
        'unique-identifier' => $self->uid(),
    );
    $self->metadata->encode($writer);
    $self->manifest->encode($writer);
    $self->spine->encode($writer);
    $self->guide->encode($writer);
    $writer->endTag("package");
}

no Moose;

1;

use v6;

unit class Stream::Buffered;

method new(Int $length, Int $maxMemoryBufferSize = 1024 * 1024) returns Stream::Buffered {
    # $maxMemoryBufferSize = 0  -> Always temp file
    # $maxMemoryBufferSize = -1 -> Always Blob
    my $backend;
    if ($maxMemoryBufferSize < 0) {
        $backend = "Blob";
    } elsif ($maxMemoryBufferSize === 0) {
        $backend = "File";
    } elsif ($length === 0) {
        $backend = "Auto";
    } elsif ($length > $maxMemoryBufferSize) {
        $backend = "File";
    } else {
        $backend = "Blob";
    }

    return Stream::Buffered.create($backend, :$maxMemoryBufferSize);
}

method create(Stream::Buffered:U: Str $backend, Int :$maxMemoryBufferSize) {
    require ::("Stream::Buffered::$backend");
    return ::("Stream::Buffered::$backend").new(:$maxMemoryBufferSize);
}

method print(Stream::Buffered:D: *@text) returns Bool { ... }

method size(Stream::Buffered:D:) returns Int { ... }

method rewind(Stream::Buffered:D:) returns IO::Handle { ... }

=begin pod

=head1 NAME

Stream::Buffered - blah blah blah

=head1 SYNOPSIS

  use Stream::Buffered;

=head1 DESCRIPTION

Stream::Buffered is ...

=head1 AUTHOR

moznion <moznion@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2015 moznion

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

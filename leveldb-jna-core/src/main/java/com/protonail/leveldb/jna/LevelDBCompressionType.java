package com.protonail.leveldb.jna;

public enum LevelDBCompressionType {
    NoCompression(0),
    SnappyCompression(1),
    ZLibCompression(2);

    private int compressionType;

    LevelDBCompressionType(int compressionType) {
        this.compressionType = compressionType;
    }

    public int getCompressionType() {
        return compressionType;
    }
}

//
//  CompressedGene.swift
//  Compression
//
//  Created by spychatter mx on 1/24/18.
//  Copyright © 2018 trenx. All rights reserved.
//

import Foundation


typealias Gene<UInt32> = (bit1:UInt32,bit2: UInt32)


struct CompressedGene {
	
	let length: Int
	private let bitVector: CFMutableBitVector
	
	init(original:String) {
		length = original.count
		bitVector = CFBitVectorCreateMutable(kCFAllocatorDefault, length * 2)
		CFBitVectorSetCount(bitVector, length * 2)
		compress(gene: original)
	}
	
	func SetBit(nStart: Int, bitCode: Gene<UInt32>){
		CFBitVectorSetBitAtIndex(bitVector, nStart, bitCode.bit1)
		CFBitVectorSetBitAtIndex(bitVector, nStart + 1, bitCode.bit2)
	}
	
	private func compress(gene:String){
		gene.uppercased().enumerated().forEach{
			let nStart = $0.offset * 2
			switch $0.element{
			case "A": //00
				SetBit(nStart: nStart, bitCode: (0,0))
				
			case "C": //01
				SetBit(nStart: nStart, bitCode: (0,1))
				
			case "G": //10
				SetBit(nStart: nStart, bitCode: (1,0))
				
			case "T": //11
				SetBit(nStart: nStart, bitCode: (1,1))
				
			default:
				print("Unexpected character \($0) at \($0.offset)")
				
			}
			
		}
	}

	
	func decompress() -> String{
		return String(Array(0..<length).reduce(""){ acc, index in
			let nStart = index * 2
			let firstBit = CFBitVectorGetBitAtIndex(bitVector, nStart)
			let secondBit = CFBitVectorGetBitAtIndex(bitVector, nStart + 1)
			
			switch (firstBit, secondBit){
			case (0,0):
				return acc + "A"
			case (0,1):
				return acc + "C"
			case (1,0):
				return acc + "G"
			case (1,1):
				return acc + "T"
			default:()
			}
			return acc
		})

	}
	
	
}

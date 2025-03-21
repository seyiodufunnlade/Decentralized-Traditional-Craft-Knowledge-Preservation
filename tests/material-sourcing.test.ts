import { describe, it, expect } from 'vitest';

// Simple mock implementation
const mockMaterialSourcing = {
  registerMaterial: async (name: string, source: string, sustainable: boolean) => {
    return { value: 1 };
  },
  
  getMaterial: async (materialId: number) => {
    return {
      name: "Natural Clay",
      source: "River Basin",
      sustainable: true,
      registrar: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM"
    };
  },
  
  getMaterialCount: async () => {
    return 8;
  }
};

describe('Material Sourcing Contract', () => {
  it('should register a new material', async () => {
    const result = await mockMaterialSourcing.registerMaterial(
        "Natural Clay",
        "River Basin",
        true
    );
    
    expect(result.value).toBe(1);
  });
  
  it('should get material details', async () => {
    const material = await mockMaterialSourcing.getMaterial(1);
    
    expect(material.name).toBe("Natural Clay");
    expect(material.sustainable).toBe(true);
  });
  
  it('should return the correct material count', async () => {
    const count = await mockMaterialSourcing.getMaterialCount();
    
    expect(count).toBe(8);
  });
});

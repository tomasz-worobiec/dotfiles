{
  disko.devices = {
    disk = {
      nvme0n1 = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "BOOT";
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              label = "LUKS";
              size = "100%";
              content = {
                type = "luks";
                name = "encrypted";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "lynx";
                };
                extraFormatArgs = [ "--label=LUKS" ];
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      lynx = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "10G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
          nix = {
            size = "100G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
          home = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}

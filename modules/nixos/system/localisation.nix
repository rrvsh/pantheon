{ config, lib, ... }:
{
  config = lib.mkMerge [
    {
	  time.timeZone = "Asia/Singapore";
	  i18n.defaultLocale = "en_US.UTF-8";
    }
  ];
}

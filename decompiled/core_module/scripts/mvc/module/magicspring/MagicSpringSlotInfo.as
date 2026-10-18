package mvc.module.magicspring
{
   import yishi.datas.templates.MagicSpringFormulaTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MagicSpringSlotInfo
   {
      
      public var tempId:int;
      
      public var validCountDown:int;
      
      public function MagicSpringSlotInfo()
      {
         super();
      }
      
      public function get tempInfo() : MagicSpringFormulaTempInfo
      {
         return TempleteManager.instance.magicSpringTempCate.getTemplateById(tempId);
      }
   }
}


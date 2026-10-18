package mvc.module.mounts
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.TempleteManager;
   
   public class MountKingInfo
   {
      
      public var templateId:int;
      
      public var extraStar:int;
      
      public var grade:int;
      
      public var exp:int;
      
      public function MountKingInfo()
      {
         super();
      }
      
      public function get template() : MountTemplate
      {
         var _loc1_:Dictionary = TempleteManager.instance.mountTemplateDic;
         return _loc1_[templateId] == null ? new MountTemplate() : _loc1_[templateId];
      }
   }
}


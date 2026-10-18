package yishi.resolve
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.utils.ClassFactory;
   
   public class CampaignTemplateResolve extends TemplateBaseResolve
   {
      
      public function CampaignTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:CampaignTemplate = ClassFactory.createInstanceIII(CampaignTemplate,_list[_index]);
         _dic[_loc1_.CampaignId] = _loc1_;
         super.resolveImp();
      }
   }
}


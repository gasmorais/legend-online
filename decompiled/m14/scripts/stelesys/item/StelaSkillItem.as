package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.stele.StelesysInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.StelaStepTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   
   public class StelaSkillItem extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _title:FilterFrameText;
      
      private var _des:FilterFrameText;
      
      private var _gray:Array;
      
      private var _isActive:Boolean;
      
      public function StelaSkillItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.stelesys.mainT1");
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.skillTitle");
         _des = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.skillDes");
         _gray = [UIFilter.getGrayFilter()];
         addChild(_bg);
         addChild(_title);
         addChild(_des);
      }
      
      public function refreshView(param1:StelesysInfo) : void
      {
         var _loc4_:SkillTempInfo = null;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            _title.text = "";
            _des.text = "";
            isActive = true;
            return;
         }
         var _loc2_:StelaStepTemplateInfo = param1.stepTempInfo;
         if(_loc2_)
         {
            _loc3_ = int(_loc2_.PassiveSkills);
            if(_loc3_ > 0)
            {
               _loc4_ = TempleteManager.instance.getSkillById(_loc3_);
            }
            if(_loc4_)
            {
               _title.text = _loc4_.TemplateName + " " + LanguageMgr.GetTranslation("dayGuide.data.DailyList.level01",_loc4_.Grades);
               _des.htmlText = _loc4_.Description;
               _des.height = _des.numLines * 20;
               isActive = param1.pos == 1;
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_des);
         _des = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         _isActive = param1;
         if(_isActive)
         {
            this.filters = null;
         }
         else
         {
            this.filters = _gray;
         }
      }
   }
}


package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GoddessDedicationSkillItem extends Component
   {
      
      private var _lock:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _desTxt:FilterFrameText;
      
      private var _desBack:Bitmap;
      
      private var _idx:int;
      
      private var _buffImgs:ScaleFrameImage;
      
      public function GoddessDedicationSkillItem(param1:int)
      {
         super();
         _idx = param1;
         initView();
      }
      
      private function initView() : void
      {
         _lock = ComponentFactory.Instance.creatBitmap("asset.goddess.lock");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.goddess.SkillIcon");
         _desBack = ComponentFactory.Instance.creatBitmap("asset.goddess.dedicationSkBg");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.dedactionSkTxt");
         _buffImgs = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.buffImgs");
         addChild(_desBack);
         addChild(_desTxt);
         addChild(_icon);
         addChild(_buffImgs);
         addChild(_lock);
         var _loc1_:String = LanguageMgr.GetTranslation("goddess.dedication.skTitle2");
         _desTxt.text = LanguageMgr.GetTranslation("goddess.dedication.skDes",_idx,_loc1_);
         _buffImgs.visible = false;
         _buffImgs.setFrame(_idx - 1);
         if(_idx == 1)
         {
            _icon.visible = true;
            _desTxt.text = LanguageMgr.GetTranslation("goddess.dedication.skillTip");
         }
         else
         {
            _icon.visible = false;
         }
      }
      
      public function refreshView(param1:SkillTempInfo) : void
      {
         _icon.icon = IconFactory.getTecIconByIcon(param1.Icons);
         var _loc2_:SkillInfo = new SkillInfo();
         _loc2_.templateId = param1.TemplateId;
         _loc2_.grade = param1.Grades;
         _icon.tipData = _loc2_;
         _lock.visible = false;
      }
      
      public function refreshViewByBuff(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc4_:int = 0;
         var _loc3_:BufferTemplateInfo = null;
         if(param1 == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("goddess.dedication.skTitle2");
            _desTxt.text = LanguageMgr.GetTranslation("goddess.dedication.skDes",_idx,_loc2_);
            _lock.visible = true;
            _icon.tipData = null;
            _buffImgs.visible = false;
         }
         else
         {
            _buffImgs.visible = true;
            _loc4_ = int(param1);
            _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc4_);
            _loc2_ = LanguageMgr.GetTranslation("goddess.dedication.skTitle1");
            _desTxt.text = LanguageMgr.GetTranslation("goddess.dedication.skDes",_idx,_loc2_);
            _lock.visible = false;
            _buffImgs.tipData = {
               "title":_desTxt.text,
               "buffTemp":_loc3_
            };
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_desBack);
         _desBack = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeObject(_buffImgs);
         _buffImgs = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


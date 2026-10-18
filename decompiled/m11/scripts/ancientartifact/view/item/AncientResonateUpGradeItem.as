package ancientartifact.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import mvc.module.ancientartifact.AncientResonateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.TempleteManager;
   
   public class AncientResonateUpGradeItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _titleBack:Bitmap;
      
      private var _maxBack:Bitmap;
      
      private var _valueTxt:FilterFrameText;
      
      private var _data:AncientResonateInfo;
      
      private var _type:int;
      
      public function AncientResonateUpGradeItem(param1:int = 1)
      {
         _type = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.upGradeViewBack09");
         _maxBack = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.upGradeViewBack08");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.upGradeViewBack0" + (5 + _type));
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateAddValueTxt");
         addChild(_back);
         addChild(_maxBack);
         addChild(_titleBack);
         addChild(_valueTxt);
         _valueTxt.setFrame(_type);
         _maxBack.visible = false;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      public function set data(param1:AncientResonateInfo) : void
      {
         _data = param1;
         var _loc4_:AncientArtifactInfo = model.getArtifactInfoById(_data.equipArtifactId);
         var _loc2_:int = int(_type == 1 ? _data.posGrades : _data.posGrades + 1);
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc2_,137);
         if(_loc3_)
         {
            _valueTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateAddTips0" + _data.pos,_loc3_.ActiveObject);
            _back.visible = true;
            _titleBack.visible = true;
            _valueTxt.visible = true;
            _maxBack.visible = false;
         }
         else if(_type == 2)
         {
            _back.visible = false;
            _titleBack.visible = false;
            _valueTxt.visible = false;
            _maxBack.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_maxBack);
         _maxBack = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         super.dispose();
      }
   }
}


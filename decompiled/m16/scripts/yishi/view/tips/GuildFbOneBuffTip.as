package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GuildFbOneBuffTip extends BaseTip
   {
      
      private var _guildfbTipTitle:FilterFrameText;
      
      private var _guildfbTipContentDes:FilterFrameText;
      
      private var _guildfbTipFlgDes:FilterFrameText;
      
      private var _guildfbTipFlgTitle:FilterFrameText;
      
      private var _guildfbBuffIcon:BaseIconView;
      
      private var _sp:Sprite;
      
      private var _line:Bitmap;
      
      public function GuildFbOneBuffTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _guildfbTipTitle = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.guildfbTipTitle");
         _guildfbTipContentDes = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.guildfbTipContentDes");
         _guildfbTipFlgDes = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.guildfbTipFlgDes");
         _guildfbTipFlgTitle = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.guildfbTipFlgTitle");
         _guildfbBuffIcon = ComponentFactory.Instance.creatCustomObject("ui.guildfb.guildfbBuffIcon");
         _line = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _sp = new Sprite();
         addChild(_guildfbTipTitle);
         addChild(_guildfbTipContentDes);
         addChild(_guildfbBuffIcon);
         addChild(_sp);
         _sp.addChild(_line);
         _sp.addChild(_guildfbTipFlgTitle);
         _sp.addChild(_guildfbTipFlgDes);
         _bg.width = 340;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SkillTempInfo = null;
         if(tipData != null)
         {
            _loc1_ = int(tipData);
            _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_);
            if(_loc2_)
            {
               _guildfbBuffIcon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
               _guildfbTipTitle.text = _loc2_.TemplateName;
               _guildfbTipContentDes.text = _loc2_.Description;
               _guildfbTipFlgTitle.text = LanguageMgr.GetTranslation("vehicle.condition");
               _guildfbTipFlgDes.text = _loc2_.OwnRequirements;
               _guildfbTipContentDes.height = _guildfbTipContentDes.numLines * 20;
               _sp.y = _guildfbTipContentDes.y + _guildfbTipContentDes.numLines * 20 + 2;
               _guildfbTipFlgDes.height = _guildfbTipFlgDes.numLines * 20;
               _bg.height = _sp.y + _sp.height + 5;
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_guildfbTipTitle);
         _guildfbTipTitle = null;
         ObjectUtils.disposeObject(_guildfbTipContentDes);
         _guildfbTipContentDes = null;
         ObjectUtils.disposeObject(_guildfbTipFlgDes);
         _guildfbTipFlgDes = null;
         ObjectUtils.disposeObject(_guildfbTipFlgTitle);
         _guildfbTipFlgTitle = null;
         ObjectUtils.disposeObject(_guildfbBuffIcon);
         _guildfbBuffIcon = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class TheseusSkillAttII extends Sprite
   {
      
      private var _panel:ScrollPanel;
      
      private var _desText:FilterFrameText;
      
      private var _pot:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _type:int;
      
      private var _title:FilterFrameText;
      
      private var _reg:RegExp = /[0-9%]+/g;
      
      public function TheseusSkillAttII(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.skTitleTxt");
         if(_type == 1)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.skLeftbg");
            _title.text = LanguageMgr.GetTranslation("theseus.war.oldSkTitle");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.skRightbg");
            _title.text = LanguageMgr.GetTranslation("theseus.war.newSkTitle");
         }
         _panel = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.skill.skPanel");
         _pot = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _desText = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.skill.SkDesTxt");
         addChild(_bg);
         addChild(_pot);
         addChild(_panel);
         addChild(_title);
         _pot.visible = false;
         _panel.setView(_desText);
      }
      
      public function setTextValue(param1:String) : void
      {
         if(param1 != null)
         {
            _panel.visible = true;
            _pot.visible = true;
            _desText.htmlText = changeNumColor(param1);
            _desText.height = _desText.numLines * 20;
         }
         else
         {
            _panel.visible = false;
            _pot.visible = false;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_pot);
         _pot = null;
         ObjectUtils.disposeObject(_desText);
         _desText = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function changeNumColor(param1:String) : String
      {
         return param1.replace(_reg,regFun);
      }
      
      private function regFun() : String
      {
         return "<font color=\'#00ff00\'>" + arguments[0] + "</font>";
      }
   }
}


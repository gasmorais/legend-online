package navigation
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import manager.LanguageMgr;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   
   public class NavigationBoadUpgradeView extends Component
   {
      
      private var levelImage:ScaleFrameImage;
      
      private var numberBitmap:BitmapData;
      
      private var levelNumContiner:Component;
      
      private var reduceTimeText:FilterFrameText;
      
      private var _grade:int;
      
      private var curUpgradeTempInfo:UpgradeTemplateInfo;
      
      public function NavigationBoadUpgradeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         levelImage = ComponentFactory.Instance.creatComponentByStylename("NavigationBoadUpgradeView.levelImage");
         numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.NavigationBoadUpgradeView.NumBmpData");
         levelNumContiner = ComponentFactory.Instance.creatComponentByStylename("NavigationBoadUpgradeView.levelNumContiner");
         reduceTimeText = ComponentFactory.Instance.creatComponentByStylename("NavigationBoadUpgradeView.reduceTimeText");
         addChild(levelImage);
         addChild(levelNumContiner);
         addChild(reduceTimeText);
      }
      
      public function set grade(param1:int) : void
      {
         reduceTimeText.text = "";
         _grade = param1;
         curUpgradeTempInfo = TempleteManager.instance.getTemplateByLevelAndType(_grade,118);
         if(!curUpgradeTempInfo)
         {
            return;
         }
         NumberViewUtils.refreshValue(_grade,levelNumContiner,numberBitmap,18,18,14,18,"1234567890");
         if(curUpgradeTempInfo.ActiveObject != 0)
         {
            reduceTimeText.text = LanguageMgr.GetTranslation("NavigationBoadUpgradeView.reduceTimeText.text",curUpgradeTempInfo.ActiveObject);
         }
      }
      
      public function set levelType(param1:int) : void
      {
         levelImage.setFrame(param1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(levelImage);
         levelImage = null;
         ObjectUtils.disposeObject(numberBitmap);
         numberBitmap = null;
         ObjectUtils.disposeObject(levelNumContiner);
         levelNumContiner = null;
         ObjectUtils.disposeObject(reduceTimeText);
         reduceTimeText = null;
      }
   }
}


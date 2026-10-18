package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.utils.NumberViewUtils;
   
   public class ChildPatrolTowerAffectView extends Component
   {
      
      private var levelImage:ScaleFrameImage;
      
      private var numberBitmap:BitmapData;
      
      private var levelNumContiner:Component;
      
      private var openTowerText:FilterFrameText;
      
      private var canPatrolCount:FilterFrameText;
      
      private var openTaskText:FilterFrameText;
      
      private var descTextContiner:VBox;
      
      private var _level:int;
      
      private var _towerId:int;
      
      private var curUpgradeTempInfo:UpgradeTemplateInfo;
      
      public function ChildPatrolTowerAffectView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         levelImage = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerAffectView.levelImage");
         numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.ChildPatrolTowerAffectView.NumBmpData");
         levelNumContiner = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerAffectView.levelNumContiner");
         openTowerText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerAffectView.towerCount");
         canPatrolCount = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerAffectView.childCount");
         openTaskText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerAffectView.taskText");
         descTextContiner = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerAffectView.descTextContiner");
         addChild(levelImage);
         addChild(levelNumContiner);
         addChild(openTowerText);
         addChild(canPatrolCount);
         addChild(openTaskText);
         addChild(descTextContiner);
      }
      
      public function set curLevel(param1:int) : void
      {
         var _loc5_:Array = null;
         var _loc2_:int = 0;
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc4_:FilterFrameText = null;
         descTextContiner.removeAllChild();
         openTowerText.text = "";
         canPatrolCount.text = "";
         openTaskText.text = "";
         _level = param1;
         NumberViewUtils.refreshValue(_level,levelNumContiner,numberBitmap,17,17,14,17,"0123456789");
         if(_towerId == 100)
         {
            curUpgradeTempInfo = model.findUpgradeTempInfoByTypeAndGrade(114,_level);
            descTextContiner.y = canPatrolCount.y + 25;
         }
         else
         {
            curUpgradeTempInfo = model.findUpgradeTempInfoByTypeAndGrade(115,_level);
            descTextContiner.y = openTaskText.y + 25;
         }
         if(curUpgradeTempInfo)
         {
            _loc5_ = curUpgradeTempInfo.TemplateName.split(",");
            _loc2_ = int(_loc5_.length);
            if(_towerId == 100)
            {
               if(_level == 10)
               {
                  openTowerText.htmlText = LanguageMgr.GetTranslation("ChildPatrolTowerAffectView.openTower10");
               }
               else
               {
                  openTowerText.htmlText = LanguageMgr.GetTranslation("ChildPatrolTowerAffectView.openTowerText.text",_level);
               }
               canPatrolCount.htmlText = LanguageMgr.GetTranslation("ChildPatrolTowerAffectView.canPatrolCount.text",_loc5_[0]);
            }
            else if(_level == 10)
            {
               openTaskText.htmlText = LanguageMgr.GetTranslation("ChildPatrolTowerAffectView.openTask10");
            }
            else
            {
               _loc6_ = LanguageMgr.GetTranslation("ChildPatrolTowerAffectView.taskText.text" + _loc5_[0]);
               openTaskText.htmlText = LanguageMgr.GetTranslation("ChildPatrolTowerAffectView.openTaskText.text",_loc6_);
            }
            _loc3_ = 1;
            while(_loc3_ < _loc2_)
            {
               if(_loc5_[_loc3_] != 0)
               {
                  _loc4_ = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerAffectView.descText");
                  descTextContiner.addChild(_loc4_);
                  _loc4_.htmlText = LanguageMgr.GetTranslation("ChildPatrolTowerAffectView.descText.text" + _loc3_,_loc5_[_loc3_]);
               }
               _loc3_++;
            }
         }
      }
      
      public function set towerId(param1:int) : void
      {
         _towerId = param1;
      }
      
      public function set levelType(param1:int) : void
      {
         levelImage.setFrame(param1);
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(levelImage);
         levelImage = null;
         ObjectUtils.disposeObject(numberBitmap);
         numberBitmap = null;
         ObjectUtils.disposeObject(levelNumContiner);
         levelNumContiner = null;
         ObjectUtils.disposeObject(openTowerText);
         openTowerText = null;
         ObjectUtils.disposeObject(canPatrolCount);
         canPatrolCount = null;
         ObjectUtils.disposeObject(openTaskText);
         openTaskText = null;
         ObjectUtils.disposeObject(descTextContiner);
         descTextContiner = null;
         curUpgradeTempInfo = null;
         super.dispose();
      }
   }
}


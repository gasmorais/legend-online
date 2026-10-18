package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   
   public class ChildPatrolTowerExpView extends Component
   {
      
      private var back:ScaleFrameImage;
      
      private var towerImage:ScaleFrameImage;
      
      private var levelTextImage:Bitmap;
      
      private var mcContiner:Component;
      
      private var levelMc:MovieClip;
      
      private var expText:FilterFrameText;
      
      private var arrowImage:Bitmap;
      
      private var curAffectView:ChildPatrolTowerAffectView;
      
      private var nextAffectView:ChildPatrolTowerAffectView;
      
      private var fullAffectView:ChildPatrolTowerAffectView;
      
      private var _data:ChildPatrolTowerInfo;
      
      public function ChildPatrolTowerExpView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerExpView.back");
         towerImage = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerExpView.towerImage");
         levelTextImage = ComponentFactory.Instance.creatBitmap("asset.ChildPatrolTowerExpView.levelTextImage");
         mcContiner = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerExpView.mcContiner");
         levelMc = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerExpView.levelMc");
         expText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerExpView.expText");
         arrowImage = ComponentFactory.Instance.creatBitmap("asset.ChildPatrolTowerExpView.arrowImage");
         curAffectView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerExpView.curAffectView");
         nextAffectView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerExpView.nextAffectView");
         fullAffectView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerExpView.fullAffectView");
         addChild(back);
         addChild(towerImage);
         addChild(levelTextImage);
         addChild(mcContiner);
         mcContiner.addChild(levelMc);
         addChild(expText);
         addChild(curAffectView);
         curAffectView.visible = false;
         addChild(nextAffectView);
         nextAffectView.visible = false;
         addChild(fullAffectView);
         fullAffectView.visible = false;
         addChild(arrowImage);
         arrowImage.visible = false;
         mcContiner.tipData = LanguageMgr.GetTranslation("ChildPatrolTowerExpView.mcContiner.tipData");
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc4_:int = 0;
         _data = param1;
         if(!_data)
         {
            return;
         }
         curAffectView.visible = false;
         nextAffectView.visible = false;
         fullAffectView.visible = false;
         curAffectView.towerId = nextAffectView.towerId = fullAffectView.towerId = _data.towerId;
         curAffectView.levelType = fullAffectView.levelType = 1;
         nextAffectView.levelType = 2;
         if(_data.towerId == 100)
         {
            _loc3_ = model.findUpgradeTempInfoByTypeAndGrade(114,_data.level);
            _loc2_ = model.findUpgradeTempInfoByTypeAndGrade(114,_data.level + 1);
            back.setFrame(1);
            back.y = -32;
            towerImage.setFrame(1);
            towerImage.x = 50;
            towerImage.y = -25;
         }
         else
         {
            _loc3_ = model.findUpgradeTempInfoByTypeAndGrade(115,_data.level);
            _loc2_ = model.findUpgradeTempInfoByTypeAndGrade(115,_data.level + 1);
            back.setFrame(2);
            back.y = -5;
            towerImage.setFrame(2);
            towerImage.x = 80;
            towerImage.y = 15;
         }
         if(!_loc2_)
         {
            _loc4_ = 100;
            expText.text = "Max";
            arrowImage.visible = false;
            fullAffectView.visible = true;
            fullAffectView.curLevel = _data.level;
         }
         else
         {
            _loc4_ = _data.curExp * 100 / _loc2_.Data;
            expText.text = _data.curExp + "/" + _loc2_.Data;
            arrowImage.visible = true;
            curAffectView.visible = true;
            nextAffectView.visible = true;
            curAffectView.curLevel = _data.level;
            nextAffectView.curLevel = _data.level + 1;
         }
         levelMc.gotoAndStop(_loc4_);
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(towerImage)
         {
            ObjectUtils.disposeObject(towerImage);
         }
         towerImage = null;
         if(levelTextImage)
         {
            ObjectUtils.disposeObject(levelTextImage);
         }
         levelTextImage = null;
         if(levelMc)
         {
            ObjectUtils.disposeViolentMc(levelMc);
         }
         levelMc = null;
         if(arrowImage)
         {
            ObjectUtils.disposeObject(arrowImage);
         }
         arrowImage = null;
         if(expText)
         {
            ObjectUtils.disposeObject(expText);
         }
         expText = null;
         if(mcContiner)
         {
            ObjectUtils.disposeObject(mcContiner);
         }
         mcContiner = null;
         if(curAffectView)
         {
            ObjectUtils.disposeObject(curAffectView);
         }
         curAffectView = null;
         if(nextAffectView)
         {
            ObjectUtils.disposeObject(nextAffectView);
         }
         nextAffectView = null;
         if(fullAffectView)
         {
            ObjectUtils.disposeObject(fullAffectView);
         }
         fullAffectView = null;
         super.dispose();
      }
   }
}


package mounts
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.MountInfo;
   import mvc.module.mounts.MountRefiningSoulInfo;
   import mvc.module.mounts.PropertyInfo;
   import yishi.datas.ConfigInfoManager;
   
   public class MountRefiningSoulItem extends Component
   {
      
      private var _headImage:ScaleFrameImage;
      
      private var _percentText:FilterFrameText;
      
      private var _levelUpMc:MovieClip;
      
      private var _headType:int;
      
      private var _prePercent:int;
      
      private var _first:Boolean = true;
      
      private var curPropName:String;
      
      private var propMaxValue:int;
      
      public function MountRefiningSoulItem(param1:int)
      {
         super();
         _headType = param1;
         curPropName = PropertyInfo.PROP_NAME_ARR[_headType - 1];
         initView();
         propMaxValue = ConfigInfoManager.instance.getMountRefiningSoulMaxValue();
      }
      
      private function initView() : void
      {
         _headImage = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoulItem.headImage");
         _percentText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoulItem.percentText");
         _levelUpMc = ComponentFactory.Instance.creatCustomObject("MountRefiningSoulItem.levelUpMc");
         addChild(_headImage);
         addChild(_percentText);
         addChild(_levelUpMc);
         _levelUpMc.mouseChildren = _levelUpMc.mouseEnabled = false;
         _levelUpMc.gotoAndStop(1);
         _headImage.setFrame(_headType);
      }
      
      public function refreshView() : void
      {
         var _loc5_:int = int(refiningSoulInfo.getPropAddPercentByPropName(curPropName));
         if(!_first && _loc5_ != _prePercent)
         {
            if(_levelUpMc)
            {
               _levelUpMc.gotoAndPlay(1);
            }
         }
         _prePercent = _loc5_;
         _first = false;
         _percentText.text = _loc5_ + "%";
         var _loc1_:int = int(refiningSoulInfo.getSkillAddPercent());
         var _loc6_:int = Math.ceil(mountInfo.getProperty(curPropName).addition * _loc1_ / 100);
         var _loc3_:int = Math.min(_loc6_,propMaxValue);
         var _loc2_:int = Math.ceil(_loc3_ * _loc5_ / 100);
         var _loc4_:String = LanguageMgr.GetTranslation("mount.prop.name." + curPropName);
         _headImage.tipData = LanguageMgr.GetTranslation("MountRefiningSoulItem.headImage.tipdata",_loc3_,_loc4_,_loc5_,_loc4_,_loc2_);
      }
      
      private function get refiningSoulInfo() : MountRefiningSoulInfo
      {
         return MountsManager.instance.selfRefiningSoulInfo;
      }
      
      private function get mountInfo() : MountInfo
      {
         return MountsManager.instance.mountInfo;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_headImage);
         _headImage = null;
         ObjectUtils.disposeObject(_percentText);
         _percentText = null;
         ObjectUtils.disposeViolentMc(_levelUpMc);
         _levelUpMc = null;
         super.dispose();
      }
   }
}


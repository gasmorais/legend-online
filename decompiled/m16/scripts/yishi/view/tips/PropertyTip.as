package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.MountRefiningSoulInfo;
   import mvc.module.mounts.PropertyInfo;
   import yishi.datas.ConfigInfoManager;
   
   public class PropertyTip extends BaseTip
   {
      
      private var _txt01:FilterFrameText;
      
      private var _txt02:FilterFrameText;
      
      private var _txt03:FilterFrameText;
      
      private var _txt04:FilterFrameText;
      
      public function PropertyTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txt01 = ComponentFactory.Instance.creatComponentByStylename("mounts.propertyTipTxt01");
         _txt02 = ComponentFactory.Instance.creatComponentByStylename("mounts.propertyTipTxt02");
         _txt03 = ComponentFactory.Instance.creatComponentByStylename("mounts.propertyTipTxt03");
         addChild(_txt01);
         addChild(_txt02);
         addChild(_txt03);
      }
      
      override protected function updateTransform() : void
      {
         var _loc6_:int = 0;
         var _loc7_:PropertyInfo = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         if(tipData)
         {
            if(tipData.hasOwnProperty("tipType") && tipData.tipType == "titan_reduce_tip_type")
            {
               _txt01.htmlText = LanguageMgr.GetTranslation("mounts.PropertyItem.tips02",tipData.nameValue,tipData.attValue);
               _txt02.htmlText = tipData.grade;
               _txt03.htmlText = tipData.upperLimit;
            }
            else
            {
               _loc6_ = int(ConfigInfoManager.instance.getMountRefiningSoulMaxValue());
               _loc7_ = tipData as PropertyInfo;
               _loc3_ = LanguageMgr.GetTranslation("mounts.command02").split(",");
               _loc4_ = int(PropertyInfo.getPropertyValue(_loc7_.name));
               _loc1_ = _loc7_.grade * 5;
               _loc8_ = Math.ceil(_loc7_.addition * refiningSoulInfo.getSkillAddPercent() / 100);
               _loc5_ = Math.min(_loc8_,_loc6_);
               _loc9_ = int(refiningSoulInfo.getPropAddPercentByPropName(_loc7_.name));
               _loc2_ = Math.ceil(_loc5_ * _loc9_ / 100);
               if(_loc7_.addition - _loc1_ > 0)
               {
                  if(_loc2_ > 0)
                  {
                     _txt01.htmlText = LanguageMgr.GetTranslation("mounts.PropertyItem.tips02",_loc3_[_loc4_],_loc1_ + " + " + (_loc7_.addition - _loc1_) + " + " + _loc2_);
                  }
                  else
                  {
                     _txt01.htmlText = LanguageMgr.GetTranslation("mounts.PropertyItem.tips02",_loc3_[_loc4_],_loc1_ + " + " + (_loc7_.addition - _loc1_));
                  }
               }
               else if(_loc2_ > 0)
               {
                  _txt01.htmlText = LanguageMgr.GetTranslation("mounts.PropertyItem.tips02",_loc3_[_loc4_],_loc1_ + " + " + _loc2_);
               }
               else
               {
                  _txt01.htmlText = LanguageMgr.GetTranslation("mounts.PropertyItem.tips02",_loc3_[_loc4_],_loc1_);
               }
               _txt02.htmlText = LanguageMgr.GetTranslation("mounts.PropertyItem.tips03",_loc3_[_loc4_],_loc7_.grade);
               _txt03.htmlText = LanguageMgr.GetTranslation("mounts.PropertyItem.tips04",_loc7_.gradeMax);
            }
            _bg.width = 260;
            _bg.height = 87;
         }
      }
      
      private function get refiningSoulInfo() : MountRefiningSoulInfo
      {
         return MountsManager.instance.selfRefiningSoulInfo;
      }
      
      override public function dispose() : void
      {
         _txt01 = null;
         _txt02 = null;
         _txt03 = null;
         _txt04 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}


package map.campaign.view.ui.snowball.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.sevenyear.SnowVehicleReportInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.utils.SimpleDictionary;
   
   public class SnowReportItem extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _rewardItem:Image;
      
      private var _rewardCountText:FilterFrameText;
      
      public var index:int;
      
      private var _data:SnowVehicleReportInfo;
      
      public function SnowReportItem(param1:int)
      {
         super();
         index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("SnowReportItem.back");
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("SnowReportItem.rankImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("SnowReportItem.rankTxt");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("SnowReportItem.rewardTxt");
         _rewardCountText = ComponentFactory.Instance.creatComponentByStylename("SnowReportItem.rewardCountText");
         _rewardItem = ComponentFactory.Instance.creatComponentByStylename("SnowReportItem.rewardItem");
         addChild(_back);
         addChild(_rankImg);
         addChild(_rankTxt);
         addChild(_rewardTxt);
         addChild(_rewardItem);
         addChild(_rewardCountText);
         _rankImg.setFrame(index);
         _rewardTxt.text = LanguageMgr.GetTranslation("box.timeBox.TimeBoxFrame.title");
         if(index == 1)
         {
            _rankTxt.x = 100;
         }
         else if(index == 2)
         {
            _rankTxt.x = 150;
         }
         else if(index == 3)
         {
            _rankTxt.x = 230;
         }
         else if(index == 4)
         {
            _rankTxt.x = 115;
         }
      }
      
      public function get data() : SnowVehicleReportInfo
      {
         return _data;
      }
      
      public function set data(param1:SnowVehicleReportInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc3_:Array = [0,0,data.eliminateNum,data.pickSkillNum,data.damage];
         if(index == 1)
         {
            if(data.isOnHook)
            {
               _rankTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverItem.isOnHook");
               _rankTxt.setFrame(2);
               _rewardCountText.text = "0";
            }
            else
            {
               _rankTxt.text = LanguageMgr.GetTranslation("warlords.WarlordsGeneralListCell.str02",data.myRank);
               _rankTxt.setFrame(1);
               _loc2_ = int(data.myRank);
               _rewardCountText.text = getRewardCount(_loc2_) + "";
            }
         }
         else
         {
            _rankTxt.text = _loc3_[index] + "";
            _rankTxt.setFrame(1);
            _loc2_ = int(_loc3_[index]);
            _rewardCountText.text = getRewardCount(_loc2_) + "";
         }
      }
      
      private function getRewardCount(param1:int) : int
      {
         if(index == 1 || index == 2)
         {
            return getRewardCount1(index,param1);
         }
         return getRewardCount2(index,param1);
      }
      
      private function getRewardCount1(param1:int, param2:int) : int
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 == 1)
         {
            _loc3_ = ConfigInfoManager.instance.getSnowVehicleOrderReward();
         }
         else
         {
            _loc3_ = ConfigInfoManager.instance.getSnowVehicleKillReward();
         }
         var _loc6_:Dictionary = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_].split(",");
            _loc6_[_loc4_[0]] = _loc4_[1];
            _loc5_++;
         }
         return _loc6_[param2] ? _loc6_[param2] : 0;
      }
      
      private function getRewardCount2(param1:int, param2:int) : int
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 == 3)
         {
            _loc3_ = ConfigInfoManager.instance.getSnowVehiclePickSKillReward();
         }
         else
         {
            _loc3_ = ConfigInfoManager.instance.getSnowVehicleDamageReward();
         }
         var _loc8_:SimpleDictionary = new SimpleDictionary();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_].split(",");
            _loc8_.add(_loc4_[0],_loc4_[1]);
            _loc5_++;
         }
         var _loc6_:Array = _loc8_.keys.sort(0x10 | 2);
         for each(var _loc7_:String in _loc6_)
         {
            if(param2 >= int(_loc7_))
            {
               return _loc8_[_loc7_];
            }
         }
         return 0;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rankImg);
         _rankImg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_rewardTxt);
         _rewardTxt = null;
         ObjectUtils.disposeObject(_rewardItem);
         _rewardItem = null;
         ObjectUtils.disposeObject(_rewardCountText);
         _rewardCountText = null;
         super.dispose();
      }
   }
}


package alchemical
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.alchemical.AlchemicalMineInfo;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.AlchemicalMineTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.AlchemicalManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   
   public class AlchemicalMineItem extends Component
   {
      
      private var mineImageContiner:Component;
      
      private var speedBtn:BaseButton;
      
      private var getRewardBtn:BaseButton;
      
      private var mineMc:MovieClip;
      
      private var _tempInfo:AlchemicalMineTempInfo;
      
      private var _data:AlchemicalMineInfo;
      
      public function AlchemicalMineItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         mineImageContiner = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMineItem.mineImageContiner");
         speedBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMineItem.speedBtn");
         getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMineItem.getRewardBtn");
         addChild(mineImageContiner);
         addChild(speedBtn);
         speedBtn.visible = false;
         addChild(getRewardBtn);
         getRewardBtn.visible = false;
      }
      
      private function addEvent() : void
      {
         speedBtn.addEventListener("click",__speedClickHandler);
         getRewardBtn.addEventListener("click",__getRewardClickHandler);
         mineImageContiner.addEventListener("rollOver",__rollOverHandler);
         this.addEventListener("rollOut",__rollOutHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeSecondHandler);
      }
      
      private function removeEvent() : void
      {
         if(speedBtn)
         {
            speedBtn.removeEventListener("click",__speedClickHandler);
         }
         if(getRewardBtn)
         {
            getRewardBtn.removeEventListener("click",__getRewardClickHandler);
         }
         if(mineImageContiner)
         {
            mineImageContiner.removeEventListener("rollOver",__rollOverHandler);
         }
         this.removeEventListener("rollOut",__rollOutHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timeSecondHandler);
      }
      
      private function __speedClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         SimpleAlertHelper.instance.data = [__alertResponseHandler,speedUpCost];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("AlchemicalMineItem.speedItem.alert",speedUpCost);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function __alertResponseHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(!param1)
         {
            return;
         }
         if(playerModel.playerInfo.point >= param3)
         {
            AlchemicalManager.instance.sendAlchemicalMineRequest(5,_data.mineId);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __timeSecondHandler(param1:PlayerEvent) : void
      {
         refreshTipAndHarvest();
      }
      
      private function __getRewardClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         AlchemicalManager.instance.sendAlchemicalMineRequest(1,_data.mineId);
      }
      
      public function __rollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = model.speedMaxCount - model.hasSpeedCount;
         speedBtn.visible = _data && tempInfo && _loc2_ > 0 && _data.curCount < tempInfo.MaxCount;
      }
      
      public function __rollOutHandler(param1:MouseEvent) : void
      {
         speedBtn.visible = false;
      }
      
      public function get tempInfo() : AlchemicalMineTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:AlchemicalMineTempInfo) : void
      {
         _tempInfo = param1;
         if(!_tempInfo)
         {
            return;
         }
         _data = model.getMineInfoByPos(_tempInfo.Pos);
         ObjectUtils.disposeAllChildren(mineImageContiner);
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onMineLoaded);
         var _loc2_:String = PathManager.getAlchemicalMineIconPath(_tempInfo.Icon);
         LoaderManagerII.instance.load(_loc2_,2,8,__onMineLoaded);
         if(_data)
         {
            mineImageContiner.filters = [];
         }
         else
         {
            mineImageContiner.filters = [UIFilter.getGrayFilter()];
            getRewardBtn.visible = false;
         }
         refreshTipAndHarvest();
      }
      
      private function __onMineLoaded(param1:LoaderInfo, param2:Object) : void
      {
         if(!mineImageContiner)
         {
            return;
         }
         if(param2)
         {
            ObjectUtils.disposeViolentMc(mineMc);
            mineMc = null;
            mineMc = param2 as MovieClip;
            mineImageContiner.addChild(mineMc);
            if(_data)
            {
               speedBtn.x = param2["cold"].x;
               speedBtn.y = param2["cold"].y;
               getRewardBtn.x = param2["harvest"].x;
               getRewardBtn.y = param2["harvest"].y;
            }
         }
      }
      
      public function refreshTipAndHarvest() : void
      {
         if(!_data)
         {
            getRewardBtn.visible = false;
            this.tipData = tempInfo.Name + "\n" + LanguageMgr.GetTranslation("AlchemicalMineItem.open.needScore",tempInfo.NeedScore);
         }
         else
         {
            getRewardBtn.visible = _data.curCount > 0;
            this.tipData = tempInfo.Name + "\n" + LanguageMgr.GetTranslation("AlchemicalMineItem.speedText.content",tempInfo.Speed) + "\n" + LanguageMgr.GetTranslation("AlchemicalMineItem.hasHarvestText.content",_data.curCount,tempInfo.MaxCount);
         }
      }
      
      public function get speedUpCost() : int
      {
         if(!_data)
         {
            return 0;
         }
         var _loc1_:Array = ConfigInfoManager.instance.getAlchemicalSpeedCostPoint();
         var _loc2_:int = _data.startTime + tempInfo.MaxCount * tempInfo.Speed - playerModel.sysCurTimeBySecond;
         return Math.ceil(_loc2_ / (60 * _loc1_[1])) * _loc1_[0];
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onMineLoaded);
         ObjectUtils.disposeViolentMc(mineMc);
         mineMc = null;
         ObjectUtils.disposeObject(mineImageContiner);
         mineImageContiner = null;
         ObjectUtils.disposeObject(speedBtn);
         speedBtn = null;
         ObjectUtils.disposeObject(getRewardBtn);
         getRewardBtn = null;
         super.dispose();
      }
   }
}


package pumpingjoy
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PumpingJoyManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.pumpingegg.PumpingJoyModel;
   import mvc.module.pumpingegg.PumpingJoyRewardInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.MsgMan;
   
   public class PumpingJoyRewardFrame extends Frame
   {
      
      private var border:ScaleBitmapImage;
      
      private var back:ScaleBitmapImage;
      
      private var rewardContiner:Component;
      
      private var itemList:Vector.<PumpingJoyRewardItem>;
      
      private var goodsFlyMc:MovieClip;
      
      private var rewardArr:Array;
      
      private var allOpenBtn:BaseButton;
      
      private var isPlayMovie:Boolean = false;
      
      public function PumpingJoyRewardFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyRewardFrame.border");
         back = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyRewardFrame.back");
         rewardContiner = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyRewardFrame.TileContainer");
         allOpenBtn = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyRewardFrame.allOpenBtn");
         addToContent(border);
         addToContent(back);
         addToContent(rewardContiner);
         addToContent(allOpenBtn);
      }
      
      private function initRewardView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:PumpingJoyRewardInfo = null;
         var _loc2_:PumpingJoyRewardItem = null;
         itemList = new Vector.<PumpingJoyRewardItem>();
         _loc4_ = 0;
         while(_loc4_ < rewardArr.length)
         {
            _loc1_ = int(rewardArr[_loc4_]);
            _loc3_ = model.getRewardInfoById(_loc1_);
            _loc2_ = ComponentFactory.Instance.creatCustomObject("PumpingJoyRewardFrame.item");
            rewardContiner.addChild(_loc2_);
            _loc2_.x = int(_loc4_ % 5) * 130 + 20;
            _loc2_.y = int(_loc4_ / 5) * 155 + 20;
            _loc2_.data = _loc3_;
            itemList.push(_loc2_);
            _loc4_++;
         }
      }
      
      private function showRewardMovie() : void
      {
         this.visible = false;
         goodsFlyMc = ComponentFactory.Instance.creatCustomObject("PumpingJoyRewardFrame.goodsFlyMc" + rewardArr.length);
         addToContent(goodsFlyMc);
         goodsFlyMc.mouseChildren = goodsFlyMc.mouseEnabled = false;
         var _loc1_:int = goodsFlyMc.totalFrames;
         isPlayMovie = true;
         goodsFlyMc.gotoAndPlay(1);
         goodsFlyMc.addFrameScript(int(_loc1_ / 2),flyMovieMiddle,_loc1_ - 1,flyMovieOver);
      }
      
      private function flyMovieMiddle() : void
      {
         this.visible = true;
      }
      
      private function flyMovieOver() : void
      {
         isPlayMovie = false;
         goodsFlyMc.stop();
         ObjectUtils.disposeViolentMc(goodsFlyMc);
         goodsFlyMc = null;
         initRewardView();
      }
      
      private function resetPosition() : void
      {
         if(rewardArr.length == 10)
         {
            this.width = 680;
            this.height = 475;
            border.width = 660;
            border.height = 388;
            back.width = 655;
            back.height = 380;
            rewardContiner.x = 5;
            rewardContiner.y = 40;
            allOpenBtn.visible = true;
            allOpenBtn.y = 360;
         }
         else
         {
            this.width = 445;
            this.height = 310;
            border.width = 425;
            border.height = 223;
            back.width = 420;
            back.height = 215;
            rewardContiner.x = 155;
            rewardContiner.y = 65;
            allOpenBtn.visible = false;
            allOpenBtn.y = 200;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         allOpenBtn.addEventListener("click",__allOpenClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         allOpenBtn.removeEventListener("click",__allOpenClickHandler);
      }
      
      private function __allOpenClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:PumpingJoyRewardItem = null;
         if(isPlayMovie)
         {
            return;
         }
         allOpenBtn.enable = false;
         var _loc3_:int = int(itemList.length);
         _loc4_ = 0;
         while(_loc4_ < itemList.length)
         {
            _loc2_ = itemList[_loc4_];
            _loc2_.openReward();
            _loc4_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PumpingJoyRewardItem = null;
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(isPlayMovie)
               {
                  return;
               }
               _loc3_ = 0;
               while(_loc3_ < itemList.length)
               {
                  _loc2_ = itemList[_loc3_];
                  if(!_loc2_.hasOpen && _loc2_.data)
                  {
                     MsgMan.notifyObserver("PUMPING_JOY_SHOW_REWARD",_loc2_.data.id);
                  }
                  _loc3_++;
               }
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.view.ui.gvgcross.reward.showReward");
         if(param1 && param1.frameData)
         {
            rewardArr = param1.frameData as Array;
            resetPosition();
            LayerManager.Instance.addToLayer(this,3,true,true,1);
            showRewardMovie();
         }
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function get model() : PumpingJoyModel
      {
         return PumpingJoyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(rewardContiner);
         rewardContiner = null;
         ObjectUtils.disposeObject(allOpenBtn);
         allOpenBtn = null;
         ObjectUtils.disposeViolentMc(goodsFlyMc);
         goodsFlyMc = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}


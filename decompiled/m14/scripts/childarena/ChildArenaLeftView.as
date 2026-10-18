package childarena
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildArenaPlayerInfo;
   import utils.LogicUtils;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.DateFormatter;
   
   public class ChildArenaLeftView extends Component
   {
      
      private var periodImage:ScaleFrameImage;
      
      private var leftTime:GradientText;
      
      private var itemContiner:Component;
      
      private var lineContiner:Component;
      
      private var childHbox:HBox;
      
      private var formationBtn:IconButton;
      
      private var alertText:FilterFrameText;
      
      private var _timer:Timer;
      
      private var childList:Vector.<ChildArenaHeadItemView>;
      
      private var vsCountArr:Array = [16,8,4,2];
      
      private var itemList16:Vector.<ChildArenaPlayerItem>;
      
      private var itemList8:Vector.<ChildArenaPlayerItem>;
      
      private var itemList4:Vector.<ChildArenaPlayerItem>;
      
      private var itemList2:Vector.<ChildArenaPlayerItem>;
      
      private var lineList8:Vector.<ScaleFrameImage>;
      
      private var lineList4:Vector.<ScaleFrameImage>;
      
      private var lineList2:Vector.<ScaleFrameImage>;
      
      private var leftPosXarr:Array = [0,110,220,313];
      
      private var rightPosXarr:Array = [630,523,410,313];
      
      private var addPosYarr:Array = [0,30,90,156];
      
      private var addPosYarr2:Array = [255,285,346,277];
      
      private var mutiPosYarr:Array = [60,120,240,0];
      
      private var leftLineArr:Array = ["01","11","21"];
      
      private var rightLineArr:Array = ["02","12","22"];
      
      private var leftPosLineXarr:Array = [0,110,185];
      
      private var rightPosLineXarr:Array = [522,415,185];
      
      private var linePosYarr:Array = [0,30,100];
      
      private var linePosYarr2:Array = [255,285,280];
      
      private var mutiLinePosYarr:Array = [120,0,0];
      
      public function ChildArenaLeftView()
      {
         super();
         initView();
         initVsListView();
         initChildView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         periodImage = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.periodImage");
         leftTime = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.leftTime");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.itemContiner");
         lineContiner = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.lineContiner");
         childHbox = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.childHbox");
         formationBtn = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.formationBtn");
         alertText = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.alertText");
         _timer = new Timer(1000);
         addChild(periodImage);
         periodImage.setFrame(1);
         addChild(leftTime);
         addChild(lineContiner);
         lineContiner.mouseEnabled = false;
         addChild(itemContiner);
         itemContiner.mouseEnabled = false;
         addChild(childHbox);
         addChild(formationBtn);
         addChild(alertText);
         alertText.text = LanguageMgr.GetTranslation("ChildArenaLeftView.alertText.text");
      }
      
      private function initVsListView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:ChildArenaPlayerItem = null;
         var _loc4_:String = null;
         var _loc8_:ScaleFrameImage = null;
         var _loc7_:int = 0;
         itemList16 = new Vector.<ChildArenaPlayerItem>();
         itemList8 = new Vector.<ChildArenaPlayerItem>();
         itemList4 = new Vector.<ChildArenaPlayerItem>();
         itemList2 = new Vector.<ChildArenaPlayerItem>();
         lineList8 = new Vector.<ScaleFrameImage>();
         lineList4 = new Vector.<ScaleFrameImage>();
         lineList2 = new Vector.<ScaleFrameImage>();
         _loc5_ = 0;
         while(_loc5_ < vsCountArr.length)
         {
            _loc2_ = int(vsCountArr[_loc5_]);
            _loc3_ = _loc2_ / 2;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildArenaLeftView.item");
               itemContiner.addChild(_loc1_);
               this["itemList" + _loc2_].push(_loc1_);
               if(_loc6_ < _loc3_)
               {
                  _loc1_.x = _loc6_ < _loc3_ / 2 ? leftPosXarr[_loc5_] : rightPosXarr[_loc5_];
                  _loc1_.y = _loc6_ % (_loc3_ / 2) * mutiPosYarr[_loc5_] + addPosYarr[_loc5_];
               }
               else
               {
                  _loc1_.x = _loc6_ - _loc3_ < _loc3_ / 2 ? leftPosXarr[_loc5_] : rightPosXarr[_loc5_];
                  _loc1_.y = _loc6_ % (_loc3_ / 2) * mutiPosYarr[_loc5_] + addPosYarr2[_loc5_];
               }
               _loc6_++;
            }
            if(_loc3_ > 1)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc3_)
               {
                  if(_loc7_ < _loc3_ / 2)
                  {
                     _loc4_ = _loc7_ < _loc3_ / 4 ? leftLineArr[_loc5_] : rightLineArr[_loc5_];
                     _loc8_ = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.lineImage" + _loc4_);
                     _loc8_.x = _loc7_ < _loc3_ / 4 ? leftPosLineXarr[_loc5_] : rightPosLineXarr[_loc5_];
                     _loc8_.y = _loc7_ % (_loc3_ / 4) * mutiLinePosYarr[_loc5_] + linePosYarr[_loc5_];
                  }
                  else
                  {
                     _loc4_ = _loc7_ - _loc3_ / 2 < int(_loc3_ / 4) ? leftLineArr[_loc5_] : rightLineArr[_loc5_];
                     _loc8_ = ComponentFactory.Instance.creatComponentByStylename("ChildArenaLeftView.lineImage" + _loc4_);
                     _loc8_.x = _loc7_ - _loc3_ / 2 < int(_loc3_ / 4) ? leftPosLineXarr[_loc5_] : rightPosLineXarr[_loc5_];
                     _loc8_.y = _loc7_ % (_loc3_ / 4) * mutiLinePosYarr[_loc5_] + linePosYarr2[_loc5_];
                  }
                  lineContiner.addChild(_loc8_);
                  _loc8_.setFrame(1);
                  this["lineList" + _loc3_].push(_loc8_);
                  _loc7_++;
               }
            }
            _loc5_++;
         }
      }
      
      private function initChildView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildArenaHeadItemView = null;
         childList = new Vector.<ChildArenaHeadItemView>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildArenaLeftView.childItem");
            childHbox.addChild(_loc1_);
            childList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         formationBtn.addEventListener("click",__formationBtnClickHandler);
         _timer.addEventListener("timer",__timeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(formationBtn)
         {
            formationBtn.removeEventListener("click",__formationBtnClickHandler);
         }
         if(_timer)
         {
            _timer.removeEventListener("timer",__timeUpdateHandler);
         }
      }
      
      private function __timeUpdateHandler(param1:Event) : void
      {
         refreshTimeView();
      }
      
      private function __formationBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childarena","FORMATION_FRAME",1);
      }
      
      public function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:ChildArenaPlayerItem = null;
         var _loc12_:ScaleFrameImage = null;
         var _loc3_:ChildArenaPlayerInfo = null;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:ChildArenaPlayerInfo = null;
         var _loc13_:ChildArenaPlayerInfo = null;
         var _loc5_:int = 0;
         _timer.start();
         refreshTimeView();
         _loc4_ = 0;
         while(_loc4_ < vsCountArr.length)
         {
            _loc9_ = int(vsCountArr[_loc4_]);
            _loc2_ = _loc9_ / 2;
            _loc6_ = 0;
            while(_loc6_ < _loc9_)
            {
               _loc10_ = 16 / _loc9_;
               _loc1_ = this["itemList" + _loc9_][_loc6_] as ChildArenaPlayerItem;
               if(_loc1_)
               {
                  _loc3_ = arenaModel.getPlayerInfoByPosAndVsList(_loc6_ + 1,arenaModel["itemData" + _loc9_],_loc10_);
                  _loc1_.data = _loc3_;
                  if(_loc3_)
                  {
                     if(_loc3_.userId == ArmyManager.instance.thane.userId)
                     {
                        _loc1_.setBack(4);
                     }
                     else if(_loc3_.winCount >= arenaModel.maxWinCount)
                     {
                        _loc1_.setBack(2);
                     }
                     else
                     {
                        _loc3_.winCount >= _loc4_ + 1 ? _loc1_.setBack(2) : _loc1_.setBack(3);
                     }
                  }
               }
               _loc6_++;
            }
            if(_loc2_ > 1)
            {
               _loc8_ = 32 / _loc9_;
               _loc7_ = 0;
               while(_loc7_ < _loc2_)
               {
                  _loc12_ = this["lineList" + _loc2_][_loc7_] as ScaleFrameImage;
                  _loc3_ = arenaModel.getPlayerInfoByPosAndVsList(_loc7_ + 1,arenaModel["itemData" + _loc2_],_loc8_);
                  if(!_loc3_)
                  {
                     _loc12_.setFrame(1);
                  }
                  else
                  {
                     _loc11_ = arenaModel.getPlayerInfoByPosAndVsList(_loc7_ * 2 + 1,arenaModel["itemData" + _loc9_],_loc10_);
                     _loc13_ = arenaModel.getPlayerInfoByPosAndVsList(_loc7_ * 2 + 2,arenaModel["itemData" + _loc9_],_loc10_);
                     if(_loc11_ && _loc3_.uuid == _loc11_.uuid)
                     {
                        _loc12_.setFrame(2);
                     }
                     else
                     {
                        _loc12_.setFrame(3);
                     }
                  }
                  _loc7_++;
               }
            }
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < childList.length)
         {
            childList[_loc5_].data = arenaModel.childAreanFromationList[_loc5_];
            _loc5_++;
         }
      }
      
      private function refreshTimeView() : void
      {
         var _loc1_:int = 0;
         if(arenaModel.curstate == 2 || arenaModel.curstate == 3)
         {
            periodImage.x = 260;
            periodImage.setFrame(1);
            periodImage.visible = true;
            _loc1_ = int(arenaModel.betLeftTime);
            leftTime.x = 325;
         }
         else if(arenaModel.curstate == 4 && Boolean(arenaModel.isSign) && arenaModel.currentTurn < 4)
         {
            periodImage.x = 305;
            periodImage.setFrame(2);
            periodImage.visible = true;
            _loc1_ = int(arenaModel.nextWarLeftCount);
            leftTime.x = 370;
         }
         else if(arenaModel.curstate == 6 || arenaModel.curstate == 0)
         {
            periodImage.setFrame(3);
            periodImage.visible = true;
            periodImage.x = 305;
         }
         else
         {
            periodImage.visible = false;
         }
         if(_loc1_ > 0)
         {
            leftTime.text = DateFormatter.getConsortiaCountDate(_loc1_);
         }
         else
         {
            _timer.stop();
            leftTime.text = "";
         }
      }
      
      private function get arenaModel() : ChildArenaModel
      {
         return ChildManager.instance.arenaModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timeUpdateHandler);
            _timer = null;
         }
         ObjectUtils.disposeObject(periodImage);
         periodImage = null;
         ObjectUtils.disposeObject(leftTime);
         leftTime = null;
         ObjectUtils.disposeObject(formationBtn);
         formationBtn = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         ObjectUtils.disposeObject(lineContiner);
         lineContiner = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(childHbox);
         childHbox = null;
         LogicUtils.disposeDisplayCollection(itemList16);
         itemList16 = null;
         LogicUtils.disposeDisplayCollection(itemList8);
         itemList8 = null;
         LogicUtils.disposeDisplayCollection(itemList4);
         itemList4 = null;
         LogicUtils.disposeDisplayCollection(itemList2);
         itemList2 = null;
         LogicUtils.disposeDisplayCollection(lineList8);
         lineList8 = null;
         LogicUtils.disposeDisplayCollection(lineList4);
         lineList4 = null;
         LogicUtils.disposeDisplayCollection(lineList2);
         lineList2 = null;
         LogicUtils.disposeDisplayCollection(childList);
         childList = null;
         super.dispose();
      }
   }
}


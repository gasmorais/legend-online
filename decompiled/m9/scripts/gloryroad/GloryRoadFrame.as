package gloryroad
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PetEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import gloryroad.component.GloryBloodHead;
   import gloryroad.component.GloryChildrenView;
   import gloryroad.component.GloryRoadPassNode;
   import gloryroad.view.GloryRoadView;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.GloryroadManager;
   import managers.SNSManager;
   import mvc.module.children.ChildData;
   import mvc.module.gloryroad.GloryRoadModel;
   import ui.resourcebar.view.PetFigureView;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.base.TokenAmountItem;
   
   public class GloryRoadFrame extends GloryRoadView
   {
      
      private const MAX_LEVEL:int = 15;
      
      private var _nodes:Vector.<GloryRoadPassNode>;
      
      private var _boxAndBuffs:Vector.<Component>;
      
      private var _btnAllLife:IconButton;
      
      private var _btnGuardLife:IconButton;
      
      private var _explainTxt:FilterFrameText;
      
      private var _allLifeToken:TokenAmountItem;
      
      private var _guardLife:TokenAmountItem;
      
      private var _headView:GloryChildrenView;
      
      private var _bloodHead:GloryBloodHead;
      
      private var _petView:PetFigureView;
      
      private var _storeBg:Bitmap;
      
      private var _rewardBg:Bitmap;
      
      private var _attBg:Bitmap;
      
      private var _storeIcon:Image;
      
      private var _rewardIcon:Image;
      
      private var _txtBgs:Vector.<Image>;
      
      private var _gloryScoreBmp:Image;
      
      private var _passScoreBmp:Bitmap;
      
      private var _gloryScoreTxt:FilterFrameText;
      
      private var _passScoreTxt:FilterFrameText;
      
      private var _attNameBmps:Array;
      
      private var _attTxts:Array;
      
      private var _starTxt:FilterFrameText;
      
      private var _starBmp:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _lifeSendTag:int;
      
      private var _figureCover:Bitmap;
      
      private var _figureCoverStrip:StripView;
      
      public function GloryRoadFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         GloryroadManager.instance.requestData();
         _titleBmp = addCreatBitmap("asset.gloryroad.title");
         var _loc6_:Array = [{
            "x":80,
            "y":550
         },{
            "x":285,
            "y":555
         },{
            "x":490,
            "y":513
         },{
            "x":545,
            "y":414
         },{
            "x":346,
            "y":433
         },{
            "x":152,
            "y":413
         },{
            "x":102,
            "y":318
         },{
            "x":293,
            "y":316
         },{
            "x":498,
            "y":314
         },{
            "x":560,
            "y":226
         },{
            "x":363,
            "y":206
         },{
            "x":142,
            "y":206
         },{
            "x":180,
            "y":119
         },{
            "x":383,
            "y":98
         },{
            "x":550,
            "y":76
         }];
         _nodes = new Vector.<GloryRoadPassNode>(15);
         var _loc1_:int = 0;
         while(_loc1_ < 15)
         {
            _nodes[_loc1_] = new GloryRoadPassNode(_loc1_ + 1);
            _nodes[_loc1_].x = _loc6_[_loc1_].x;
            _nodes[_loc1_].y = _loc6_[_loc1_].y;
            _nodes[_loc1_].clickHanlder = clickHanlder;
            addToContent(_nodes[_loc1_]);
            _loc1_++;
         }
         _boxAndBuffs = new Vector.<Component>(14);
         _loc6_ = [{
            "x":155,
            "y":535
         },{
            "x":566,
            "y":503
         },{
            "x":295,
            "y":430
         },{
            "x":186,
            "y":317
         },{
            "x":544,
            "y":290
         },{
            "x":298,
            "y":223
         },{
            "x":257,
            "y":123
         }];
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc2_ = _loc1_ * 2;
            _boxAndBuffs[_loc2_] = addCreatComponentByStylename("gloryroad.boxImg");
            _boxAndBuffs[_loc2_].x = _loc6_[_loc1_].x;
            _boxAndBuffs[_loc2_].y = _loc6_[_loc1_].y;
            _boxAndBuffs[_loc2_].name = "box_" + _loc1_;
            _boxAndBuffs[_loc2_].tipStyle = "yishi.view.tips.OneLineTip";
            _boxAndBuffs[_loc2_].tipData = getLanuage("GloryRoadFrame.initView.tipData1");
            _boxAndBuffs[_loc2_].buttonMode = true;
            _boxAndBuffs[_loc2_].addEventListener("click",__rewardClickHanlder);
            _loc1_++;
         }
         _loc6_ = [{
            "x":368,
            "y":548
         },{
            "x":489,
            "y":411
         },{
            "x":109,
            "y":399
         },{
            "x":379,
            "y":337
         },{
            "x":500,
            "y":222
         },{
            "x":108,
            "y":186
         },{
            "x":466,
            "y":105
         }];
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc2_ = _loc1_ * 2 + 1;
            _boxAndBuffs[_loc2_] = addCreatComponentByStylename("gloryroad.buffImg");
            _boxAndBuffs[_loc2_].x = _loc6_[_loc1_].x;
            _boxAndBuffs[_loc2_].y = _loc6_[_loc1_].y;
            _boxAndBuffs[_loc2_].name = "buff_" + _loc1_;
            _boxAndBuffs[_loc2_].tipStyle = "yishi.view.tips.OneLineTip";
            _boxAndBuffs[_loc2_].tipData = getLanuage("GloryRoadFrame.initView.tipData2");
            _boxAndBuffs[_loc2_].buttonMode = true;
            _boxAndBuffs[_loc2_].addEventListener("click",__rewardClickHanlder);
            _loc1_++;
         }
         _btnAllLife = addCreatComponentByStylename("gloryroad.btnAllLife");
         _btnAllLife.tipData = getLanuage("GloryRoadFrame.initView.tipData3");
         _btnGuardLife = addCreatComponentByStylename("gloryroad.btnGuardLife");
         _btnGuardLife.tipData = getLanuage("GloryRoadFrame.initView.tipData4");
         _allLifeToken = addCreatComponentByStylename("gloryroad.allLifeToken");
         _guardLife = addCreatComponentByStylename("gloryroad.guardLifeToken");
         _headView = addCreatCustomObject("gloryroad.childrenHead");
         _attBg = addCreatBitmap("gloryroad.attBg");
         _storeBg = addCreatBitmap("asset.gloryroad.linkBg");
         _rewardBg = addCreatBitmap("asset.gloryroad.linkBg");
         _rewardBg.y = 508;
         _storeIcon = addCreatComponentByStylename("gloryroad.storeImg");
         _rewardIcon = addCreatComponentByStylename("gloryroad.rewardImg");
         _loc6_ = [116,154,190,228,265,340,532];
         _txtBgs = new Vector.<Image>(7);
         var _loc3_:Array = getLanuage("GloryRoadFrame.initView.txtTips").split("|");
         _loc4_ = 0;
         while(_loc4_ < 7)
         {
            _txtBgs[_loc4_] = addCreatComponentByStylename("gloryroad.attTxtBg");
            _txtBgs[_loc4_].y = _loc6_[_loc4_];
            _txtBgs[_loc4_].tipData = _loc3_[_loc4_];
            _loc4_++;
         }
         _gloryScoreBmp = addCreatComponentByStylename("gloryroad.mainGloryScoer");
         _passScoreBmp = addCreatBitmap("asset.gloryroad.passScore");
         _gloryScoreTxt = addCreatComponentByStylename("gloryroad.socreTxt");
         _passScoreTxt = addCreatComponentByStylename("gloryroad.passScoreTxt");
         _starTxt = addCreatComponentByStylename("gloryroad.starTxt");
         _starBmp = addCreatBitmap("asset.gloryroad.star");
         _attNameBmps = new Array(4);
         _attTxts = new Array(4);
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            _attNameBmps[_loc5_] = addCreatBitmap("asset.gloryroad.att" + _loc5_);
            _attNameBmps[_loc5_].y = 158 + _loc5_ * 37;
            _attTxts[_loc5_] = addCreatComponentByStylename("gloryroad.attTxt");
            _attTxts[_loc5_].y = 158 + _loc5_ * 37;
            _loc5_++;
         }
         _explainTxt = addCreatComponentByStylename("gloryroad.progressExplain");
         _explainTxt.text = getLanuage("GloryRoadFrame.initView.explainTxt");
         _bloodHead = new GloryBloodHead();
         this.addToContent(_bloodHead);
         _petView = addCreatCustomObject("gloryroad.PetFigureView");
         _petView.data = PlayerManager.instance.currentPlayerModel.playerInfo.enterWarPet;
         _figureCover = creatBitmap("asset.resourcesBar.FigureCover");
         _figureCoverStrip = addCreatCustomObject("gloryroad.figureCoverStrip");
         _figureCoverStrip.addChild(_figureCover);
      }
      
      protected function __rewardClickHanlder(param1:MouseEvent) : void
      {
         var _loc3_:String = param1.target.name;
         var _loc2_:Array = _loc3_.split("_");
         if(_loc2_[0] == "box")
         {
            FrameControllerManager.instance.openControllerByInfo("gloryroad","glory_road_treasure");
         }
         else if(_loc2_[0] == "buff")
         {
            FrameControllerManager.instance.openControllerByInfo("gloryroad","glory_road_buff");
         }
      }
      
      private function clickHanlder() : void
      {
         var _loc1_:String = null;
         if(model.jumpLayer > 0)
         {
            _loc1_ = getLanuage("GloryRoadFrame.clickHanlder.tip",model.jumpLayer);
            LogicUtils.alert(_loc1_,"SIMPLE_ALERT",jumperHandler);
         }
         else if(model.difficulty != 0)
         {
            GloryroadManager.instance.fight(model.difficulty);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("gloryroad","glory_road_difficulty");
         }
      }
      
      private function jumperHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            model.showAfterJumper = true;
            GloryroadManager.instance.skipLayer(1);
            FrameControllerManager.instance.openControllerByInfo("gloryroad","glory_road_treasure");
         }
         else
         {
            GloryroadManager.instance.skipLayer(0);
            FrameControllerManager.instance.openControllerByInfo("gloryroad","glory_road_difficulty");
         }
      }
      
      override protected function initEvent() : void
      {
         addEvent(_btnAllLife,"click",__btnClickHandler);
         addEvent(_btnGuardLife,"click",__btnClickHandler);
         addEvent(_storeIcon,"click",__btnClickHandler);
         addEvent(_rewardIcon,"click",__btnClickHandler);
         addEvent(_storeIcon,"mouseOver",__iconMouserOverHandler);
         addEvent(_rewardIcon,"mouseOver",__iconMouserOverHandler);
         addEvent(_storeIcon,"mouseOut",__iconMouseOutHanlder);
         addEvent(_rewardIcon,"mouseOut",__iconMouseOutHanlder);
         addEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         addEvent(SNSManager.instance,"SNSINFO_UPDATE",__snsInfoUpdateHandler);
         addEvent(thane,"THANE_LEVEL_UPDATE",__heroLevelUpdate);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
         if(_petView)
         {
            addEvent(PlayerManager.instance.currentPlayerModel.playerInfo,"PET_ENTERWAR_CHANGE",__updatePetHandler);
         }
         super.initEvent();
      }
      
      override protected function removeEvent() : void
      {
         deleteEvent(_btnAllLife,"click",__btnClickHandler);
         deleteEvent(_btnGuardLife,"click",__btnClickHandler);
         deleteEvent(_storeIcon,"click",__btnClickHandler);
         deleteEvent(_rewardIcon,"click",__btnClickHandler);
         deleteEvent(_storeIcon,"mouseOver",__iconMouserOverHandler);
         deleteEvent(_rewardIcon,"mouseOver",__iconMouserOverHandler);
         deleteEvent(_storeIcon,"mouseOut",__iconMouseOutHanlder);
         deleteEvent(_rewardIcon,"mouseOut",__iconMouseOutHanlder);
         deleteEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         deleteEvent(SNSManager.instance,"SNSINFO_UPDATE",__snsInfoUpdateHandler);
         deleteEvent(thane,"THANE_LEVEL_UPDATE",__heroLevelUpdate);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
         if(_petView)
         {
            deleteEvent(PlayerManager.instance.currentPlayerModel.playerInfo,"PET_ENTERWAR_CHANGE",__updatePetHandler);
         }
         super.removeEvent();
      }
      
      private function __updateGodwinerPoint(param1:NotificationEvent) : void
      {
         _gloryScoreTxt.text = model.getGloryCoinAmount().toString();
      }
      
      private function __heroLevelUpdate(param1:PlayerEvent) : void
      {
         if(thane.grades >= 50)
         {
            _figureCoverStrip.visible = false;
         }
         else
         {
            _figureCoverStrip.visible = true;
            _figureCoverStrip.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",50);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __updatePetHandler(param1:PetEvent) : void
      {
         _petView.data = param1.target.enterWarPet;
      }
      
      private function __snsInfoUpdateHandler() : void
      {
         _bloodHead.updateHead();
      }
      
      private function __refreshView(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc8_:String = null;
         var _loc5_:int = 0;
         var _loc4_:int = int(model.layer);
         _loc4_ = int(_loc4_ < 0 ? 0 : _loc4_);
         _nodes.forEach(setViewVisible);
         _boxAndBuffs.forEach(setViewVisible);
         _gloryScoreTxt.text = model.getGloryCoinAmount().toString();
         _starTxt.text = model.buffStar.toString();
         var _loc9_:ChildData = model.getChildData();
         _headView.setData(_loc9_,model.getChildPet());
         _btnGuardLife.enable = _loc9_ != null;
         _headView.clickEnabled = model.layer >= 1 ? false : true;
         if(model.childRemainHp)
         {
            _headView.enabled = model.childRemainHp.low > 0 ? true : false;
         }
         _passScoreTxt.text = model.score.toString();
         var _loc6_:String = getLanuage("GloryRoadTreasureFrame.refreshView.gloryTip",model.totalScore,model.score - Math.ceil(model.totalScore * 0.1));
         _txtBgs[6].tipData = _loc6_;
         var _loc10_:Object = model.getAllResurgenceInfo();
         _allLifeToken.firstText = _loc10_.pay;
         _allLifeToken.secondText = _loc10_.txt;
         _guardLife.firstText = model.getOneResurgencePay().toString();
         _bloodHead.updateBood();
         var _loc7_:int = int(model.viewSate);
         if(_loc7_ == 0)
         {
            if(_loc4_ < 15)
            {
               _nodes[_loc4_].visible = true;
               _nodes[_loc4_].updateHero();
               _nodes[_loc4_].tipData = model.mirrorInfo;
            }
         }
         else if(_loc7_ == 1)
         {
            if(_loc4_ < 15)
            {
               _loc2_ = _loc4_ - 1;
               if(_loc2_ >= 0)
               {
                  _boxAndBuffs[_loc2_].visible = true;
                  LogicUtils.addTweenFilter(_boxAndBuffs[_loc2_]);
               }
            }
         }
         var _loc11_:Dictionary = model.getBuffAtts();
         _loc5_ = 0;
         while(_loc5_ < _attTxts.length)
         {
            _loc3_ = _loc11_[_loc5_ + 1];
            if(_loc3_.per == 0 && _loc3_.value == 0)
            {
               _loc8_ = "0";
            }
            else
            {
               _loc8_ = _loc3_.per > 0 ? _loc3_.per + "%" : "";
               if(_loc3_.value > 0)
               {
                  if(_loc8_)
                  {
                     _loc8_ += "+" + _loc3_.value;
                  }
                  else
                  {
                     _loc8_ += _loc3_.value;
                  }
               }
            }
            _attTxts[_loc5_].text = _loc8_;
            _loc5_++;
         }
      }
      
      private function setViewVisible(param1:DisplayObject, param2:Object, param3:Object) : void
      {
         param1.visible = false;
         LogicUtils.removeTweenFilter(param1);
      }
      
      private function __iconMouserOverHandler(param1:MouseEvent) : void
      {
         DisplayObject(param1.target).filters = [UIFilter.getGlowFilter()];
      }
      
      private function __iconMouseOutHanlder(param1:MouseEvent) : void
      {
         DisplayObject(param1.target).filters = null;
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_ == _btnAllLife)
         {
            _lifeSendTag = 0;
            if(model.isTopLayer)
            {
               GloryroadManager.instance.resurgence(_lifeSendTag);
            }
            else
            {
               LogicUtils.alert(getLanuage("GloryRoadFrame.btnClickHandler.alert1",model.getConfig().resurgencePoint),"SIMPLE_ALERT",suerHandler);
            }
         }
         else if(_loc2_ == _btnGuardLife)
         {
            _lifeSendTag = 1;
            if(model.isTopLayer)
            {
               GloryroadManager.instance.resurgence(_lifeSendTag);
            }
            else
            {
               LogicUtils.alert(getLanuage("GloryRoadFrame.btnClickHandler.alert2",model.getConfig().resurgenceChildPoint),"USEBINDPOINT_ALERT",suerHandler,true);
            }
         }
         else if(_loc2_ == _storeIcon)
         {
            FrameControllerManager.instance.openControllerByInfo("shop",1008);
         }
         else if(_loc2_ == _rewardIcon)
         {
            FrameControllerManager.instance.openControllerByInfo("gloryroad","glory_road_score");
         }
      }
      
      private function suerHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc4_:int = -1;
         if(_lifeSendTag == 0)
         {
            _loc3_ = int(model.getAllResurgenceInfo().pay);
            if(!LogicUtils.judgePointEnoughToShowPay(_loc3_,false))
            {
               return;
            }
         }
         else if(_lifeSendTag == 1)
         {
            if(!LogicUtils.judgePointEnoughToShowPay(model.getOneResurgencePay(),true))
            {
               return;
            }
            _loc4_ = param2 ? 0 : 1;
         }
         GloryroadManager.instance.resurgence(_lifeSendTag,_loc4_);
      }
      
      public function get model() : GloryRoadModel
      {
         return GloryroadManager.instance.model;
      }
      
      public function show() : void
      {
         closeButton.x = 900;
         closeButton.y = 35;
         LayerManager.Instance.addToLayer(this,3,true,true);
         __refreshView(null);
         __heroLevelUpdate(null);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function removeBBEvent(param1:DisplayObject) : void
      {
         LogicUtils.removeTweenFilter(param1);
         param1.removeEventListener("click",__rewardClickHanlder);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_nodes,LogicUtils.removeTweenFilter);
         _nodes = null;
         LogicUtils.disposeDisplayCollection(_boxAndBuffs,removeBBEvent);
         _boxAndBuffs = null;
         LogicUtils.disposeDisplayCollection(_txtBgs);
         _txtBgs = null;
         LogicUtils.disposeDisplayCollection(_attNameBmps);
         _attNameBmps = null;
         LogicUtils.disposeDisplayCollection(_attTxts);
         _attTxts = null;
         ObjectUtils.disposeObject(_figureCover);
         _figureCover = null;
         ObjectUtils.disposeObject(_figureCoverStrip);
         _figureCoverStrip = null;
         ObjectUtils.disposeObject(_btnAllLife);
         _btnAllLife = null;
         ObjectUtils.disposeObject(_btnGuardLife);
         _btnGuardLife = null;
         ObjectUtils.disposeObject(_explainTxt);
         _explainTxt = null;
         ObjectUtils.disposeObject(_allLifeToken);
         _allLifeToken = null;
         ObjectUtils.disposeObject(_guardLife);
         _guardLife = null;
         ObjectUtils.disposeObject(_headView);
         _headView = null;
         ObjectUtils.disposeObject(_bloodHead);
         _bloodHead = null;
         ObjectUtils.disposeObject(_storeBg);
         _storeBg = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_attBg);
         _attBg = null;
         ObjectUtils.disposeObject(_storeIcon);
         _storeIcon = null;
         ObjectUtils.disposeObject(_rewardIcon);
         _rewardIcon = null;
         ObjectUtils.disposeObject(_attBg);
         _attBg = null;
         ObjectUtils.disposeObject(_gloryScoreBmp);
         _gloryScoreBmp = null;
         ObjectUtils.disposeObject(_passScoreBmp);
         _passScoreBmp = null;
         ObjectUtils.disposeObject(_gloryScoreTxt);
         _gloryScoreTxt = null;
         ObjectUtils.disposeObject(_passScoreTxt);
         _passScoreTxt = null;
         ObjectUtils.disposeObject(_starTxt);
         _starTxt = null;
         ObjectUtils.disposeObject(_starBmp);
         _starBmp = null;
         ObjectUtils.disposeObject(_petView);
         _petView = null;
         ObjectUtils.disposeObject(_titleBmp);
         _titleBmp = null;
         ObjectUtils.disposeObject(_petView);
         _petView = null;
         ObjectUtils.disposeObject(_titleBmp);
         _titleBmp = null;
         super.dispose();
      }
   }
}


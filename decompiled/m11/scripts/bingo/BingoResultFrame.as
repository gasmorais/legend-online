package bingo
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.bingo.BingoRankPlayerMsg;
   import com.road.yishi.proto.bingo.BingoResultDataMsg;
   import com.road.yishi.proto.bingo.BingoResultSnapMsg;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.BingoManager;
   import yishi.utils.DateFormatter;
   
   public class BingoResultFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _titleBg:MutipleImage;
      
      private var _rankTitleTxt:FilterFrameText;
      
      private var _nameTitleTxt:FilterFrameText;
      
      private var _fightTitleTxt:FilterFrameText;
      
      private var _winCountTitleTxt:FilterFrameText;
      
      private var _groupBtn1:SelectedIconTextButton;
      
      private var _groupBtn2:SelectedIconTextButton;
      
      private var _groupBtn3:SelectedIconTextButton;
      
      private var _groupBtn4:SelectedIconTextButton;
      
      private var _groupSelectedGroup:SelectedButtonGroup;
      
      private var _background:Scale9CornerImage;
      
      private var _cellLine1:DisplayObject;
      
      private var _cellLine2:DisplayObject;
      
      private var _snapArr:Array = [];
      
      private var _item1:BingoResultItem;
      
      private var _item2:BingoResultItem;
      
      private var _item3:BingoResultItem;
      
      public function BingoResultFrame()
      {
         super();
         initView();
         addEvent();
         _groupSelectedGroup.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,538,292);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc1_:BingoResultSnapMsg = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = 0;
         titleText = LanguageMgr.GetTranslation("bingo.BingoResultFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoResultFrameBack");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoResultFrame.TitleBg");
         _groupBtn1 = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoResultFrame.GroupBtn1");
         _groupBtn2 = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoResultFrame.GroupBtn2");
         _groupBtn3 = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoResultFrame.GroupBtn3");
         _groupBtn4 = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoResultFrame.GroupBtn4");
         _rankTitleTxt = ComponentFactory.Instance.creatComponentByStylename("bingo.RankTitleTxt");
         _nameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("bingo.NumTitleTxt");
         _fightTitleTxt = ComponentFactory.Instance.creatComponentByStylename("bingo.NoteTitleTxt");
         _winCountTitleTxt = ComponentFactory.Instance.creatComponentByStylename("bingo.DistributeTitleTxt");
         _background = ComponentFactory.Instance.creatComponentByStylename("bingo.describeBackground_style33");
         _cellLine1 = ComponentFactory.Instance.creatComponentByStylename("bingo.BetListCellLine");
         _cellLine2 = ComponentFactory.Instance.creatComponentByStylename("bingo.BetListCellLine");
         _item1 = ComponentFactory.Instance.creatCustomObject("bingo.BingoResultItem1");
         _item2 = ComponentFactory.Instance.creatCustomObject("bingo.BingoResultItem2");
         _item3 = ComponentFactory.Instance.creatCustomObject("bingo.BingoResultItem3");
         addToContent(_back);
         addToContent(_background);
         addToContent(_titleBg);
         addToContent(_rankTitleTxt);
         addToContent(_nameTitleTxt);
         addToContent(_fightTitleTxt);
         addToContent(_winCountTitleTxt);
         addToContent(_cellLine1);
         _cellLine1.x = 11;
         _cellLine1.y = 93;
         addToContent(_cellLine2);
         _cellLine2.x = 11;
         _cellLine2.y = 130;
         addToContent(_item1);
         _item1.index = 0;
         addToContent(_item2);
         _item2.index = 1;
         addToContent(_item3);
         _item3.index = 2;
         addToContent(_groupBtn1);
         addToContent(_groupBtn2);
         addToContent(_groupBtn3);
         addToContent(_groupBtn4);
         _groupSelectedGroup = new SelectedButtonGroup();
         _groupSelectedGroup.addSelectItem(_groupBtn1);
         _groupSelectedGroup.addSelectItem(_groupBtn2);
         _groupSelectedGroup.addSelectItem(_groupBtn3);
         _groupSelectedGroup.addSelectItem(_groupBtn4);
         _rankTitleTxt.text = LanguageMgr.GetTranslation("bingo.view.HeroRankFrame.rank");
         _nameTitleTxt.text = LanguageMgr.GetTranslation("bingo.view.HeroRankFrame.str03");
         _fightTitleTxt.text = LanguageMgr.GetTranslation("bingo.view.HeroRankFrame.str04");
         _winCountTitleTxt.text = LanguageMgr.GetTranslation("bingo.view.HeroRankFrame.str02");
         _snapArr = BingoManager.instance.snapDataArr;
         var _loc2_:Array = [];
         var _loc7_:String = "";
         _loc2_ = _snapArr.slice(0,_snapArr.length);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc5_] as BingoResultSnapMsg;
            _loc4_ = Number(DateFormatter.parse(_loc1_.eventDate + " 00:00:00","YYYY-MM-DD hh:mm:ss").time);
            _loc1_.time = _loc4_;
            _loc5_++;
         }
         _loc2_.sortOn("time",16);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc7_ = _loc2_[_loc5_].eventDate;
            _loc6_ = 0;
            while(_loc6_ < _snapArr.length)
            {
               _loc1_ = _snapArr[_loc6_] as BingoResultSnapMsg;
               if(_loc7_ == _snapArr[_loc6_].eventDate)
               {
                  _loc1_.realIdx = _loc5_;
               }
               _loc6_++;
            }
            _loc5_++;
         }
         _snapArr = _loc2_;
         _loc3_ = 0;
         while(_loc3_ < _snapArr.length)
         {
            _loc1_ = _snapArr[_loc3_] as BingoResultSnapMsg;
            this["_groupBtn" + (_loc3_ + 1)].text = String(_loc1_.eventDate.split("-")[2]);
            _loc3_++;
         }
         _loc3_ = _loc3_;
         while(_loc3_ < 4)
         {
            this["_groupBtn" + (_loc3_ + 1)].visible = false;
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.addEventListener("change",__selectedHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.removeEventListener("change",__selectedHandler);
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         var _loc7_:BingoRankPlayerMsg = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         SoundManager.instance.play("022");
         var _loc9_:int = int(_groupSelectedGroup.selectIndex);
         var _loc5_:BingoResultSnapMsg = _snapArr[_loc9_] as BingoResultSnapMsg;
         if(!_loc5_)
         {
            return;
         }
         var _loc12_:BingoResultDataMsg = BingoManager.instance.resultDataArr[_loc5_.realIdx] as BingoResultDataMsg;
         var _loc10_:int = 0;
         var _loc2_:Array = [];
         var _loc4_:Array = [[1,0,0],[2,0,0],[3,0,0]];
         _loc8_ = 0;
         while(_loc8_ < _loc5_.lotteryPlayer.length)
         {
            _loc7_ = _loc5_.lotteryPlayer[_loc8_] as BingoRankPlayerMsg;
            if(_loc7_.rank == 1)
            {
               _loc10_ = 0;
               while(_loc10_ < _loc7_.player.length)
               {
                  _loc2_ = _loc7_.player[_loc10_].split("#");
                  _loc6_ += int(_loc2_[_loc2_.length - 1]);
                  _loc10_++;
               }
               _loc4_[0][1] = _loc6_;
            }
            if(_loc7_.rank == 2)
            {
               _loc6_ = 0;
               _loc10_ = 0;
               while(_loc10_ < _loc7_.player.length)
               {
                  _loc2_ = _loc7_.player[_loc10_].split("#");
                  _loc6_ += int(_loc2_[_loc2_.length - 1]);
                  _loc10_++;
               }
               _loc4_[1][1] = _loc6_;
            }
            if(_loc7_.rank == 3)
            {
               _loc6_ = 0;
               _loc10_ = 0;
               while(_loc10_ < _loc7_.player.length)
               {
                  _loc2_ = _loc7_.player[_loc10_].split("#");
                  _loc6_ += int(_loc2_[_loc2_.length - 1]);
                  _loc10_++;
               }
               _loc4_[2][1] = _loc6_;
            }
            _loc8_++;
         }
         var _loc3_:int = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc12_.rankData.length)
         {
            if(_loc12_.rankData[_loc11_].rank >= _loc3_)
            {
               _loc3_ = int(_loc12_.rankData[_loc11_].rank);
            }
            _loc11_++;
         }
         if(_loc3_ == 1)
         {
            _loc4_[0][2] = _loc5_.tatalPond;
         }
         else if(_loc3_ == 2)
         {
            _loc4_[0][2] = int(_loc5_.tatalPond * 60 / 100);
            _loc4_[1][2] = int(_loc5_.tatalPond * 40 / 100);
         }
         else if(_loc3_ == 3)
         {
            _loc4_[0][2] = int(_loc5_.tatalPond * 50 / 100);
            _loc4_[1][2] = int(_loc5_.tatalPond * 30 / 100);
            _loc4_[2][2] = int(_loc5_.tatalPond * 20 / 100);
         }
         _item1.data = _loc4_[0];
         _item2.data = _loc4_[1];
         _item3.data = _loc4_[2];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_rankTitleTxt);
         _rankTitleTxt = null;
         ObjectUtils.disposeObject(_nameTitleTxt);
         _nameTitleTxt = null;
         ObjectUtils.disposeObject(_fightTitleTxt);
         _fightTitleTxt = null;
         ObjectUtils.disposeObject(_winCountTitleTxt);
         _winCountTitleTxt = null;
         ObjectUtils.disposeObject(_groupBtn1);
         _groupBtn1 = null;
         ObjectUtils.disposeObject(_groupBtn2);
         _groupBtn2 = null;
         ObjectUtils.disposeObject(_groupBtn3);
         _groupBtn3 = null;
         ObjectUtils.disposeObject(_groupBtn4);
         _groupBtn4 = null;
         ObjectUtils.disposeObject(_groupSelectedGroup);
         _groupSelectedGroup = null;
         ObjectUtils.disposeObject(_background);
         _background = null;
         ObjectUtils.disposeObject(_cellLine1);
         _cellLine1 = null;
         ObjectUtils.disposeObject(_cellLine2);
         _cellLine2 = null;
         ObjectUtils.disposeObject(_item1);
         _item1 = null;
         ObjectUtils.disposeObject(_item2);
         _item2 = null;
         ObjectUtils.disposeObject(_item3);
         _item3 = null;
         _snapArr = null;
         super.dispose();
      }
   }
}


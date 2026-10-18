package sqmemory
{
   import avatar.view.ShowAvatar;
   import com.adobe.images.JPGEncoder;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import manager.LanguageMgr;
   import managers.SqMemoryManger;
   import sqmemory.item.SqmemoryItem;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class SqmemoryShareFrame extends Frame
   {
      
      private var _photoSp:Sprite;
      
      private var _bg:Bitmap;
      
      private var _niceName:FilterFrameText;
      
      private var _labelBg:Bitmap;
      
      private var _leftFllower:Bitmap;
      
      private var _rightFllower:Bitmap;
      
      private var _titleT1:FilterFrameText;
      
      private var _changeBtn:IconButton;
      
      private var _shareBtn:IconButton;
      
      private var _figure:ShowAvatar;
      
      private var _rightVbox:VBox;
      
      private var _titleTag:Array = [];
      
      private var _tsp:Sprite;
      
      private var _keys:Array = [];
      
      private var _jpgSp:Sprite;
      
      private var _jpgBg:Bitmap;
      
      private var _jpgNick:FilterFrameText;
      
      private var _jpgTitle:FilterFrameText;
      
      private var _jpgFigure:ShowAvatar;
      
      private var _jpgVbox:VBox;
      
      private var _jpgTsp:Sprite;
      
      private var _jpgLabelBg:Bitmap;
      
      public function SqmemoryShareFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _photoSp = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("asset.sqmemory.shareBg");
         _niceName = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.niceName");
         _labelBg = ComponentFactory.Instance.creatBitmap("asset.sqmemory.labelBg");
         _leftFllower = ComponentFactory.Instance.creatBitmap("asset.sqmemory.leftFllower");
         _rightFllower = ComponentFactory.Instance.creatBitmap("asset.sqmemory.rightFllower");
         _titleT1 = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.titleT1");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.changeBtn");
         _shareBtn = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.shareBtn");
         _figure = new ShowAvatar(true);
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.share.rbox");
         _tsp = new Sprite();
         addToContent(_photoSp);
         _photoSp.addChild(_bg);
         _photoSp.addChild(_niceName);
         _photoSp.addChild(_labelBg);
         _photoSp.addChild(_leftFllower);
         _photoSp.addChild(_rightFllower);
         _photoSp.addChild(_titleT1);
         _photoSp.addChild(_figure);
         _photoSp.addChild(_rightVbox);
         _photoSp.addChild(_tsp);
         addToContent(_changeBtn);
         addToContent(_shareBtn);
         _keys.push("asset.sqmemory.loginT");
         _keys.push("asset.sqmemory.fightT");
         _keys.push("asset.sqmemory.killT");
         _keys.push("asset.sqmemory.victoryT");
         _keys.push("asset.sqmemory.fbT");
         _keys.push("asset.sqmemory.fashionT");
         _keys.push("asset.sqmemory.mountT");
         _keys.push("asset.sqmemory.consortiaT");
         _titleT1.text = LanguageMgr.GetTranslation("sqMemory.summary.title1");
         _niceName.text = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
         _figure.x = 168;
         _figure.y = 218;
         _tsp.x = 579;
         _tsp.y = 101;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         _jpgSp = new Sprite();
         _jpgTsp = new Sprite();
         _jpgBg = new Bitmap(_bg.bitmapData);
         _jpgLabelBg = new Bitmap(_labelBg.bitmapData);
         _jpgTitle = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.shareJpgTitle");
         _jpgTitle.text = _titleT1.text;
         _jpgNick = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.shareNickTest");
         _jpgNick.text = _niceName.text;
         _jpgVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.share.jpgrbox");
         _jpgFigure = new ShowAvatar(true);
         _jpgFigure.mouseChildren = _jpgFigure.mouseEnabled = false;
         _jpgFigure.scaleX = 0.5;
         _jpgFigure.scaleY = 0.47;
         _jpgBg.scaleX = 0.5;
         _jpgBg.scaleY = 0.47;
         _jpgLabelBg.scaleX = 0.5;
         _jpgLabelBg.scaleY = 0.47;
         _jpgTsp.scaleX = 0.5;
         _jpgTsp.scaleY = 0.47;
         _jpgFigure.x = 91;
         _jpgFigure.y = 103;
         _jpgTsp.x = 279;
         _jpgTsp.y = 47;
         _jpgLabelBg.x = 179;
         _jpgLabelBg.y = 42;
         _jpgSp.addChild(_jpgBg);
         _jpgSp.addChild(_jpgNick);
         _jpgSp.addChild(_jpgLabelBg);
         _jpgSp.addChild(_jpgTitle);
         _jpgSp.addChild(_jpgFigure);
         _jpgSp.addChild(_jpgVbox);
         _jpgSp.addChild(_jpgTsp);
         showAvater();
      }
      
      private function initData() : void
      {
         var _loc3_:SqmemoryItem = null;
         var _loc6_:SqmemoryItem = null;
         var _loc9_:String = null;
         var _loc4_:Array = null;
         var _loc1_:String = null;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         _loc10_ = 2;
         var _loc2_:int = 0;
         _loc2_ = -999;
         var _loc8_:String = SqMemoryManger.Instance.userDataInfo.shareInfo;
         var _loc7_:Array = _loc8_.split("|");
         _jpgVbox.beginChanges();
         _rightVbox.beginChanges();
         _loc9_ = _loc7_[0];
         if(_loc9_ != "#")
         {
            _loc3_ = new SqmemoryItem(2);
            _loc4_ = _loc9_.split(",");
            _loc5_ = _loc4_.shift();
            _titleTag[0] = getDayTag(_loc5_);
            _loc4_.unshift("sqMemory.summary.day");
            _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc4_);
            _loc3_.updateView(_loc1_);
            _rightVbox.addChild(_loc3_);
            _loc6_ = new SqmemoryItem(-999);
            _loc6_.updateView(_loc3_.getContentStr());
            _jpgVbox.addChild(_loc6_);
         }
         _loc9_ = _loc7_[1];
         if(_loc9_ != "#")
         {
            _loc3_ = new SqmemoryItem(2);
            _loc4_ = _loc9_.split(",");
            _loc5_ = _loc4_.shift();
            _titleTag[1] = getFightTag(_loc5_);
            _loc4_.unshift("sqMemory.summary.forcevalue" + _titleTag[1]);
            _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc4_);
            _loc3_.updateView(_loc1_);
            _rightVbox.addChild(_loc3_);
            _loc6_ = new SqmemoryItem(-999);
            _loc6_.updateView(_loc3_.getContentStr());
            _jpgVbox.addChild(_loc6_);
         }
         _loc9_ = _loc7_[2];
         if(_loc9_ != "#")
         {
            _loc3_ = new SqmemoryItem(2);
            _loc4_ = _loc9_.split(",");
            _loc5_ = _loc4_.shift();
            _titleTag[2] = getWarHonerTag(_loc5_);
            _loc4_.unshift("sqMemory.summary.honor");
            _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc4_);
            _loc3_.updateView(_loc1_);
            _rightVbox.addChild(_loc3_);
         }
         _loc9_ = _loc7_[3];
         if(_loc9_ != "#")
         {
            _loc3_ = new SqmemoryItem(2);
            _loc4_ = _loc9_.split(",");
            _loc5_ = _loc4_.shift();
            _titleTag[3] = getVictoryTag(_loc5_);
            _loc4_.unshift("sqMemory.summary.due");
            _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc4_);
            _loc3_.updateView(_loc1_);
            _rightVbox.addChild(_loc3_);
         }
         _loc9_ = _loc7_[4];
         if(_loc9_ != "#")
         {
            _loc3_ = new SqmemoryItem(2);
            _loc4_ = _loc9_.split(",");
            _loc5_ = _loc4_.shift();
            _titleTag[4] = getFBTag(_loc5_);
            _loc4_.unshift("sqMemory.summary.fb");
            _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc4_);
            _loc3_.updateView(_loc1_);
            _rightVbox.addChild(_loc3_);
         }
         _loc9_ = _loc7_[5];
         if(_loc9_ != "#")
         {
            _loc3_ = new SqmemoryItem(2);
            _loc4_ = _loc9_.split(",");
            _loc5_ = _loc4_.shift();
            _titleTag[5] = getFashionTag(_loc5_);
            _loc4_.unshift("sqMemory.summary.fashion" + _titleTag[5]);
            _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc4_);
            _loc3_.updateView(_loc1_);
            _rightVbox.addChild(_loc3_);
            _loc6_ = new SqmemoryItem(-999);
            _loc6_.updateView(_loc3_.getContentStr());
            _jpgVbox.addChild(_loc6_);
         }
         _loc9_ = _loc7_[6];
         if(_loc9_ != "#")
         {
            _loc3_ = new SqmemoryItem(2);
            _loc4_ = _loc9_.split(",");
            _loc5_ = _loc4_.shift();
            _titleTag[6] = getMountTag(_loc5_);
            _loc4_.unshift("sqMemory.summary.mount" + _titleTag[6]);
            _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc4_);
            _loc3_.updateView(_loc1_);
            _rightVbox.addChild(_loc3_);
         }
         _loc9_ = _loc7_[7];
         if(_loc9_ != "#")
         {
            _loc3_ = new SqmemoryItem(2);
            _loc4_ = _loc9_.split(",");
            _loc5_ = _loc4_.shift();
            _titleTag[7] = getConsortiaTag(_loc5_);
            if(_titleTag[7] == 1)
            {
               _loc4_.unshift("sqMemory.summary.party1");
            }
            else
            {
               _loc4_.unshift("sqMemory.summary.party2");
            }
            _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc4_);
            _loc3_.updateView(_loc1_);
            _rightVbox.addChild(_loc3_);
         }
         _loc6_ = new SqmemoryItem(-999);
         _loc6_.updateView(LanguageMgr.GetTranslation("sqMemory.share.dottt"));
         _jpgVbox.addChild(_loc6_);
         _rightVbox.commitChanges();
         _jpgVbox.commitChanges();
         changeTile();
      }
      
      private function changeTile() : void
      {
         var _loc4_:int = int(SqMemoryManger.Instance.currSelectIdx);
         var _loc2_:String = _keys[_loc4_];
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap(_loc2_ + _titleTag[_loc4_]);
         _loc3_.x = -_loc3_.width * 0.5;
         ObjectUtils.disposeAllChildren(_tsp);
         _tsp.addChild(_loc3_);
         var _loc1_:Bitmap = new Bitmap(_loc3_.bitmapData);
         _loc1_.x = -_loc3_.width * 0.5;
         ObjectUtils.disposeAllChildren(_jpgTsp);
         _jpgTsp.addChild(_loc1_);
      }
      
      private function getDayTag(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 < 299)
         {
            _loc2_ = 1;
         }
         else if(param1 < 599)
         {
            _loc2_ = 2;
         }
         else if(param1 < 999)
         {
            _loc2_ = 3;
         }
         else if(param1 < 1799)
         {
            _loc2_ = 4;
         }
         else if(param1 < 2499)
         {
            _loc2_ = 5;
         }
         else
         {
            _loc2_ = 6;
         }
         return _loc2_;
      }
      
      private function getFightTag(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 < 60)
         {
            _loc2_ = 1;
         }
         else if(param1 < 80)
         {
            _loc2_ = 2;
         }
         else if(param1 < 95)
         {
            _loc2_ = 3;
         }
         else
         {
            _loc2_ = 4;
         }
         return _loc2_;
      }
      
      private function getWarHonerTag(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 < 9999)
         {
            _loc2_ = 1;
         }
         else if(param1 < 199999)
         {
            _loc2_ = 2;
         }
         else if(param1 < 499999)
         {
            _loc2_ = 3;
         }
         else
         {
            _loc2_ = 4;
         }
         return _loc2_;
      }
      
      private function getVictoryTag(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 < 999)
         {
            _loc2_ = 1;
         }
         else if(param1 < 2999)
         {
            _loc2_ = 2;
         }
         else if(param1 < 5999)
         {
            _loc2_ = 3;
         }
         else if(param1 < 8999)
         {
            _loc2_ = 4;
         }
         else if(param1 < 11999)
         {
            _loc2_ = 5;
         }
         else
         {
            _loc2_ = 6;
         }
         return _loc2_;
      }
      
      private function getFBTag(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 < 499)
         {
            _loc2_ = 1;
         }
         else if(param1 < 1999)
         {
            _loc2_ = 2;
         }
         else if(param1 < 3999)
         {
            _loc2_ = 3;
         }
         else
         {
            _loc2_ = 4;
         }
         return _loc2_;
      }
      
      private function getFashionTag(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 < 30)
         {
            _loc2_ = 1;
         }
         else if(param1 < 61)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 3;
         }
         return _loc2_;
      }
      
      private function getMountTag(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 <= 30)
         {
            _loc2_ = 1;
         }
         else if(param1 <= 59)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 3;
         }
         return _loc2_;
      }
      
      private function getConsortiaTag(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 <= 0)
         {
            _loc2_ = 1;
         }
         else if(param1 <= 5)
         {
            _loc2_ = 2;
         }
         else if(param1 <= 30)
         {
            _loc2_ = 3;
         }
         else
         {
            _loc2_ = 4;
         }
         return _loc2_;
      }
      
      private function showAvater() : void
      {
         _figure.data = ArmyManager.instance.thane;
         _jpgFigure.data = ArmyManager.instance.thane;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _changeBtn.addEventListener("click",changeHandler);
         _shareBtn.addEventListener("click",shareHandler);
         NotificationManager.instance.addEventListener("SqmemorySelectEvent",selectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _changeBtn.removeEventListener("click",changeHandler);
         _shareBtn.removeEventListener("click",shareHandler);
         NotificationManager.instance.removeEventListener("SqmemorySelectEvent",selectHandler);
      }
      
      private function selectHandler(param1:NotificationEvent) : void
      {
         changeTile();
      }
      
      private function changeHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("sqmemory",2,_titleTag);
      }
      
      private function shareHandler(param1:MouseEvent) : void
      {
         if(SqMemoryManger.Instance.userDataInfo.isReward)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sqmemory.hasGetReward"));
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("sqmemory",3);
         }
         shareCopySendImg();
      }
      
      private function shareCopySendImg() : void
      {
         _shareBtn.enable = false;
         var _loc6_:BitmapData = new BitmapData(_jpgBg.width,_jpgBg.height);
         _loc6_.draw(_jpgSp);
         var _loc4_:JPGEncoder = new JPGEncoder(90);
         var _loc2_:ByteArray = _loc4_.encode(_loc6_);
         var _loc7_:String = "uid=" + Number(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         _loc7_ = _loc7_ + ("&appid=" + PathManager.info.FACEBOOK_SHARE_APPID);
         _loc7_ = _loc7_ + ("&appurl=" + PathManager.info.FACEBOOK_SHARE_PATH);
         var _loc5_:String = PathManager.info.REQUEST_PATH + "sqshare?" + _loc7_;
         var _loc1_:URLRequest = new URLRequest(_loc5_);
         _loc1_.data = _loc2_;
         _loc1_.method = "POST";
         _loc1_.contentType = "application/octet-stream";
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener("complete",__sendComplete);
         _loc3_.addEventListener("ioError",__sendError);
         _loc3_.load(_loc1_);
      }
      
      private function __sendError(param1:IOErrorEvent) : void
      {
         _shareBtn.enable = true;
      }
      
      private function __sendComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         _shareBtn.enable = true;
         param1.target.removeEventListener("complete",__sendComplete);
         param1.target.removeEventListener("ioError",__sendError);
         var _loc4_:XML = new XML(param1.target.data);
         if(int(_loc4_.@value) == 1)
         {
            _loc2_ = _loc4_.@message;
            _loc3_ = "https://www.facebook.com/sharer.php?u=" + _loc2_;
            if(ExternalInterface.available)
            {
               ExternalInterface.call("window.open(\'" + _loc3_ + "\')");
            }
         }
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_rightVbox);
         ObjectUtils.disposeObject(_rightVbox);
         _rightVbox = null;
         ObjectUtils.disposeObject(_niceName);
         _niceName = null;
         ObjectUtils.disposeObject(_labelBg);
         _labelBg = null;
         ObjectUtils.disposeObject(_leftFllower);
         _leftFllower = null;
         ObjectUtils.disposeObject(_rightFllower);
         _rightFllower = null;
         ObjectUtils.disposeObject(_titleT1);
         _titleT1 = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_shareBtn);
         _shareBtn = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_jpgFigure);
         _jpgFigure = null;
         ObjectUtils.disposeAllChildren(_jpgSp);
         _jpgSp = null;
         super.dispose();
         _keys = null;
         _titleTag = null;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
   }
}


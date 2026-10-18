package consortia.view.myConsortia.treasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.net.ConsortiaSocektSendManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.MyTreasureInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConsortiaTreasureTemplateInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   
   public class MyTreasureItem extends Component
   {
      
      private var _data:MyTreasureInfo;
      
      private var bg:Bitmap;
      
      private var _IconBg:Bitmap;
      
      private var _itemView:BaseItemView;
      
      private var _HelpBtn:IconButton;
      
      private var _ReceiveBtn:IconButton;
      
      private var _title:FilterFrameText;
      
      private var _assist:FilterFrameText;
      
      private var _time:FilterFrameText;
      
      private var _timeTimeDown:TimeDownView;
      
      private var _hbox:HBox;
      
      public var index:int;
      
      private var _HelpCount:int;
      
      private var tmpinfo:ConsortiaTreasureTemplateInfo;
      
      private var _HelpMaxTime:int = 1;
      
      public function MyTreasureItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         bg = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureItemBg2");
         _IconBg = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureItemIconBg");
         _itemView = ComponentFactory.Instance.creatCustomObject("consortia.MyTreasureItem.ItemView");
         _HelpBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasureItem.HelpBtn");
         _ReceiveBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasureItem.ReceiveBtn");
         _title = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasureItem.title");
         _assist = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasureItem.assist");
         _time = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasureItem.time");
         _timeTimeDown = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasureItem.timeTimeDown");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasureItem.Hbox");
         addChild(bg);
         addChild(_IconBg);
         addChild(_itemView);
         addChild(_ReceiveBtn);
         addChild(_HelpBtn);
         addChild(_title);
         _title.text = "";
         addChild(_assist);
         _assist.text = "";
         addChild(_time);
         _time.text = "";
         addChild(_timeTimeDown);
         addChild(_hbox);
      }
      
      public function set data(param1:MyTreasureInfo) : void
      {
         var _loc2_:Date = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc11_:GoodsInfo = null;
         var _loc5_:BaseItemView = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         tmpinfo = ConsortiaManager.instance.getTreasureTempByID(_data.treasureTemplateId);
         _title.text = tmpinfo.TemplateName;
         _title.setFrame(tmpinfo.Quality);
         _HelpCount = _data.requestHelpCount;
         chenkTime();
         var _loc10_:PlayerModel = PlayerManager.instance.currentPlayerModel;
         if(_loc10_.castle_offset == -1)
         {
            _loc2_ = (_data as PlayerModel).sysCurtime;
         }
         else
         {
            _loc2_ = DateFormatter.getTimezoneOffsetDate(_loc10_.castle_offset);
         }
         var _loc6_:Number = _loc2_.time;
         var _loc3_:Number = _data.newOpenTime + tmpinfo.RewardSeconds * 1000 - _loc6_;
         if(_data.status == 2)
         {
            _assist.text = "";
            _time.text = "";
            _timeTimeDown.pause();
            _HelpBtn.visible = false;
            _ReceiveBtn.visible = true;
            _ReceiveBtn.enable = true;
         }
         else if(_data.status == 1)
         {
            _assist.text = LanguageMgr.GetTranslation("consortia.MyTreasureItem.Assist") + _data.helperName;
            _assist.setFrame(1);
            _time.text = LanguageMgr.GetTranslation("consortia.MyTreasureItem.ReceiveTime");
            _time.setFrame(1);
            _timeTimeDown.timeCount = Math.ceil(_loc3_ / 1000);
            _timeTimeDown.timeTxt.setFrame(1);
            _HelpBtn.visible = false;
            _ReceiveBtn.visible = true;
            _ReceiveBtn.enable = false;
         }
         else
         {
            _assist.text = LanguageMgr.GetTranslation("consortia.MyTreasureItem.noAssist");
            _assist.setFrame(2);
            _time.text = LanguageMgr.GetTranslation("consortia.MyTreasureItem.HelpTime");
            _time.setFrame(2);
            _timeTimeDown.timeCount = Math.ceil(_loc3_ / 1000);
            _timeTimeDown.timeTxt.setFrame(2);
            _HelpBtn.visible = true;
            _ReceiveBtn.visible = false;
            _ReceiveBtn.enable = false;
         }
         _timeTimeDown.x = _time.x + _time.textWidth;
         var _loc4_:String = IconFactory.getCommonIconPath("/treasure/" + tmpinfo.Type + "_" + tmpinfo.Quality + ".png");
         _itemView.icon.icon = _loc4_;
         var _loc7_:Array = tmpinfo.Drop.split("|");
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_].split(",");
            _loc11_ = new GoodsInfo();
            _loc11_.templateId = int(_loc9_[0]);
            _loc11_.count = int(_loc9_[1]);
            _loc5_ = ComponentFactory.Instance.creatCustomObject("consortia.TreasureItem.HBoxItem");
            _loc5_.data = _loc11_;
            _hbox.addChild(_loc5_);
            _loc8_++;
         }
      }
      
      private function chenkTime() : void
      {
         if(_HelpCount >= _HelpMaxTime)
         {
            _HelpBtn.enable = false;
         }
      }
      
      private function _ReceiveBtnHandle(param1:MouseEvent) : void
      {
         ConsortiaSocektSendManager.sendOpenTreasure(6,-1,_data.treasureId);
      }
      
      private function _HelpBtnHandle(param1:MouseEvent) : void
      {
         _HelpCount = _HelpCount + 1;
         chenkTime();
         ConsortiaSocektSendManager.sendOpenTreasure(8,-1,_data.treasureId);
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         if(_data.helperName.length > 0)
         {
            _assist.text = "";
            _time.text = "";
            _timeTimeDown.pause();
            _HelpBtn.visible = false;
            _ReceiveBtn.visible = true;
            _ReceiveBtn.enable = true;
         }
         else
         {
            _timeTimeDown.pause();
            _HelpBtn.visible = false;
            _ReceiveBtn.visible = false;
            _ReceiveBtn.enable = false;
            NotificationManager.instance.sendNotification("MYTREASURE_REMOVE",index);
         }
      }
      
      private function initEvent() : void
      {
         _timeTimeDown.addEventListener("timerDown_complete",__timeCompleteHandler);
         _ReceiveBtn.addEventListener("click",_ReceiveBtnHandle);
         _HelpBtn.addEventListener("click",_HelpBtnHandle);
      }
      
      private function removeEvent() : void
      {
         if(_timeTimeDown)
         {
            _timeTimeDown.removeEventListener("timerDown_complete",__timeCompleteHandler);
         }
         if(_ReceiveBtn)
         {
            _ReceiveBtn.removeEventListener("click",_ReceiveBtnHandle);
         }
         if(_HelpBtn)
         {
            _HelpBtn.removeEventListener("click",_HelpBtnHandle);
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(bg)
         {
            ObjectUtils.disposeObject(bg);
         }
         bg = null;
         if(_IconBg)
         {
            ObjectUtils.disposeObject(_IconBg);
         }
         _IconBg = null;
         if(_itemView)
         {
            ObjectUtils.disposeObject(_itemView);
         }
         _itemView = null;
         if(_ReceiveBtn)
         {
            ObjectUtils.disposeObject(_ReceiveBtn);
         }
         _ReceiveBtn = null;
         if(_HelpBtn)
         {
            ObjectUtils.disposeObject(_HelpBtn);
         }
         _HelpBtn = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_assist)
         {
            ObjectUtils.disposeObject(_assist);
         }
         _assist = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(_timeTimeDown)
         {
            ObjectUtils.disposeObject(_timeTimeDown);
         }
         _timeTimeDown = null;
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
         }
         _hbox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}


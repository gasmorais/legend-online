package marry.quality
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.MarryManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarryQuality;
   import mvc.module.marry.MarrySender;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryQualityFrame extends Frame implements IManualSize
   {
      
      private var _buttonBack:Bitmap;
      
      private var _selectBtn:IconButton;
      
      private var _kiloView:MarryKiloView;
      
      private var _nobleView:MarryNobleView;
      
      private var _commonView:MarryCommonView;
      
      private var _group:SelectedButtonGroup;
      
      private var _qualityList:Vector.<MarryKiloView>;
      
      private var _posX:Array = [5,347,654];
      
      public function MarryQualityFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,977,645);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MarryKiloView = null;
         titleText = LanguageMgr.GetTranslation("marry.quality.MarryQualityFrame.titleText");
         _buttonBack = ComponentFactory.Instance.creatBitmap("asset.marry.buttonBack");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("MarryQualityFrame.selectBtn");
         _group = new SelectedButtonGroup();
         _qualityList = new Vector.<MarryKiloView>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new MarryKiloView(_loc2_ + 1);
            _loc1_.x = _posX[_loc2_];
            _loc1_.y = 25;
            addToContent(_loc1_);
            _group.addSelectItem(_loc1_);
            _qualityList.push(_loc1_);
            _loc2_++;
         }
         addToContent(_buttonBack);
         addToContent(_selectBtn);
         _group.selectIndex = 0;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectBtn.addEventListener("click",__commitHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selectBtn.removeEventListener("click",__commitHandler);
      }
      
      private function __commitHandler(param1:MouseEvent) : void
      {
         var _loc8_:MarryQuality = new MarryQuality();
         _loc8_.qualityId = _group.selectIndex + 1;
         var _loc4_:int = int(model.getMarryQualityCosts(_loc8_.qualityId));
         if(playerIndo.point < _loc4_)
         {
            RechargeAlertMannager.show();
            return;
         }
         if(FreedomTeamManager.instance.model == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.needTeam2"));
            return;
         }
         if(FreedomTeamManager.instance.model.captainId != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.marryquality.notcaptain"));
            return;
         }
         SimpleAlertHelper.instance.data = [confirmCallback];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("marry.marryquality.quality" + _loc8_.qualityId);
         var _loc7_:String = LanguageMgr.GetTranslation("marry.marryquality.chooseQualityContent",_loc4_,_loc5_);
         if(MarryManager.instance.model.selfMarryInfo.isBackPlayerFirstMarried)
         {
            _loc7_ += LanguageMgr.GetTranslation("marry.marryquality.chooseQualityContent2");
         }
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,false,false,true);
      }
      
      private function confirmCallback(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MarrySender.buyQuality(_group.selectIndex + 1,model.selfMarryInfo.userId,1);
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get playerIndo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         var _loc1_:MarryKiloView = null;
         removeEvent();
         while(_qualityList.length > 0)
         {
            _loc1_ = _qualityList.pop();
            _loc1_.dispose();
            _loc1_ = null;
         }
         _qualityList = null;
         if(_selectBtn)
         {
            _selectBtn.dispose();
         }
         _selectBtn = null;
         if(_buttonBack)
         {
            _buttonBack.bitmapData.dispose();
         }
         _buttonBack = null;
         if(_group)
         {
            _group.dispose();
         }
         _group = null;
         super.dispose();
      }
   }
}


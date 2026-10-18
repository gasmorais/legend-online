package outyard.shuttle
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ArrayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   
   public class OutyardShuttleFightPetFrame extends Frame implements IManualSize
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _bg:Bitmap;
      
      private var _fightPetBmp:Bitmap;
      
      private var _petNote:FilterFrameText;
      
      private var _headItem:ShuttlePetHeadItemView;
      
      private var _petHeadList:Vector.<ShuttlePetHeadItemView>;
      
      private var _currentSelectedItem:ShuttlePetHeadItemView;
      
      public function OutyardShuttleFightPetFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,338,302);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ShuttlePetHeadItemView = null;
         titleText = LanguageMgr.GetTranslation("outyard.OutyardShuttleFightPetFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardShuttleFightPet.Back");
         _bg = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.fightSetBg");
         _fightPetBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.fightPetBmp");
         _petNote = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.petNote");
         addToContent(_back);
         addToContent(_bg);
         addToContent(_fightPetBmp);
         addToContent(_petNote);
         _headItem = new ShuttlePetHeadItemView();
         _headItem.x = 27;
         _headItem.y = 53;
         addToContent(_headItem);
         _petHeadList = new Vector.<ShuttlePetHeadItemView>(3);
         var _loc2_:Array = [{
            "x":29,
            "y":153
         },{
            "x":95,
            "y":153
         },{
            "x":160,
            "y":153
         }];
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = new ShuttlePetHeadItemView(_loc3_);
            _loc1_.x = _loc2_[_loc3_].x;
            _loc1_.y = _loc2_[_loc3_].y;
            _loc1_.addEventListener("click",__mouseClickHandler);
            addToContent(_loc1_);
            _petHeadList[_loc3_] = _loc1_;
            _loc3_++;
         }
         _petNote.text = LanguageMgr.GetTranslation("outyard.OutyardShuttleFightPetFrame.note");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("UPDATE_SHUTTLE_VIEW",__updateShuttleHandler);
         __updateShuttleHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("UPDATE_SHUTTLE_VIEW",__updateShuttleHandler);
      }
      
      private function __updateShuttleHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         if(_loc2_.fightPet)
         {
            _headItem.data = getPet(_loc2_.fightPet);
         }
         var _loc3_:Array = ArrayUtils.cloneArray(_loc2_.petList);
         _loc4_ = 0;
         while(_loc4_ < _petHeadList.length)
         {
            if(_loc3_[_loc4_] != 0)
            {
               _petHeadList[_loc4_].data = getPet(_loc3_[_loc4_]);
            }
            _loc4_++;
         }
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(param1.currentTarget is ShuttlePetHeadItemView)
         {
            _currentSelectedItem = param1.currentTarget as ShuttlePetHeadItemView;
         }
         if(_currentSelectedItem && _currentSelectedItem.data)
         {
            OutyardManager.instance.OperateShuttle(3,_currentSelectedItem.data.petId);
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      private function getPet(param1:int) : PetData
      {
         var _loc2_:int = 0;
         var _loc3_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].petId == param1)
            {
               return _loc3_[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_fightPetBmp);
         _fightPetBmp = null;
         ObjectUtils.disposeObject(_petNote);
         _petNote = null;
         ObjectUtils.disposeObject(_headItem);
         _headItem = null;
         if(_petHeadList)
         {
            while(_petHeadList.length)
            {
               ObjectUtils.disposeObject(_petHeadList.pop());
            }
         }
         _currentSelectedItem = null;
         super.dispose();
      }
   }
}


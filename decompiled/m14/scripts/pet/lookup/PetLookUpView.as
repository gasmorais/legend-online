package pet.lookup
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.pet.PetData;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class PetLookUpView extends Frame implements IManualSize
   {
      
      private var _currentFrame:PetLookUpFrame;
      
      private var _selfFrame:PetLookUpFrame;
      
      public function PetLookUpView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(playerInfo.enterWarPet)
         {
            return new Rectangle(0,0,700,500);
         }
         return new Rectangle(0,0,335,500);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _currentFrame = ComponentFactory.Instance.creatComponentByStylename("PetLookUpView.selfFrame");
         _currentFrame.titleText = LanguageMgr.GetTranslation("ThaneAttributeTip.pet");
         _currentFrame.isSelf = false;
         addChild(_currentFrame);
         if(playerInfo.enterWarPet)
         {
            _selfFrame = ComponentFactory.Instance.creatComponentByStylename("PetLookUpView.selfFrame");
            _selfFrame.titleText = LanguageMgr.GetTranslation("pet.lookup.PetLookUpView.myPet");
            _selfFrame.isSelf = true;
            addChild(_selfFrame);
            _selfFrame.x = 360;
         }
      }
      
      private function initEvent() : void
      {
         if(_currentFrame)
         {
            _currentFrame.addEventListener("response",__frameResponse);
         }
         if(_selfFrame)
         {
            _selfFrame.addEventListener("response",__frameResponse);
         }
      }
      
      private function removeEvent() : void
      {
         if(_currentFrame)
         {
            _currentFrame.removeEventListener("response",__frameResponse);
         }
         if(_selfFrame)
         {
            _selfFrame.removeEventListener("response",__frameResponse);
         }
      }
      
      private function set data(param1:PetData) : void
      {
         for each(var _loc2_:GoodsInfo in param1.equipList)
         {
            _loc2_.id = 999999;
         }
         if(_currentFrame)
         {
            _currentFrame.data = param1;
         }
         if(_selfFrame)
         {
            _selfFrame.data = playerInfo.enterWarPet;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_selfFrame)
               {
                  _selfFrame.x = 0;
               }
               ObjectUtils.disposeObject(param1.currentTarget);
               this.x = (StageReferance.gameStageWidth - 335) / 2;
         }
         if(_currentFrame && !_currentFrame.isDie)
         {
            StageReferance.stage.focus = _currentFrame;
         }
         if(_selfFrame && !_selfFrame.isDie)
         {
            StageReferance.stage.focus = _selfFrame;
         }
         if((_currentFrame == null || Boolean(_currentFrame.isDie)) && (_selfFrame == null || Boolean(_selfFrame.isDie)))
         {
            dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         if(param1)
         {
            data = param1.frameData as PetData;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_currentFrame);
         _currentFrame = null;
         ObjectUtils.disposeObject(_selfFrame);
         _selfFrame = null;
         super.dispose();
      }
   }
}


package consortia.view.fb
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.controler.GuildFbController;
   import mvc.module.guildfb.GuildFBNode;
   import yishi.datas.ComponentGroupType;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class GuildFBFightFrame extends Frame implements IEnterFrame
   {
      
      private var _ui:GuildFBFightUIView;
      
      private var _currTime:Number = 0;
      
      private var _fightPlayerView:GuildFBFightInfoFrame;
      
      public function GuildFBFightFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:GuildFBNode) : void
      {
         _ui.setData(param1,true);
         titleText = param1.currTempInfo.Name;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1.rewardState == 3)
         {
            __historyBtnHandler(null);
            _currTime = getTimer();
            EnterFrameManager.instance.registeEnterFrame(this);
         }
      }
      
      private function initView() : void
      {
         _ui = new GuildFBFightUIView();
         addToContent(_ui);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_ui.fightBtn)
         {
            _ui.fightBtn.addEventListener("click",_fightClickHandler);
         }
         MsgMan.addObserver("GuildFBModel.fightInfo",this,fightNodeChangeHandler);
         MsgMan.addObserver("GuildFBModel.fightNode",this,nodeChangeHandler);
         MsgMan.addObserver("GuildFBModel.raceReset",this,raceRestHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_ui.fightBtn)
         {
            _ui.fightBtn.removeEventListener("click",_fightClickHandler);
         }
         MsgMan.removeObserver("GuildFBModel.fightInfo",this,fightNodeChangeHandler);
         MsgMan.removeObserver("GuildFBModel.fightNode",this,nodeChangeHandler);
         MsgMan.removeObserver("GuildFBModel.raceReset",this,raceRestHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function raceRestHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function nodeChangeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GuildFBNode = null;
         if(_ui)
         {
            if(_ui.data)
            {
               _loc3_ = control.model.getFightNodeByNodeId(_ui.data.nodeID);
               _ui.setData(_loc3_,false);
            }
         }
      }
      
      public function enterFrame() : void
      {
         if(getTimer() - _currTime > 10000)
         {
            _currTime = getTimer();
            if(_ui && _ui.data)
            {
               if(_ui.data.rewardState == 3)
               {
                  control.requestOp(1,_ui.data.nodeID);
               }
               else
               {
                  if(_fightPlayerView)
                  {
                     _fightPlayerView.dispose();
                  }
                  EnterFrameManager.instance.unRegisteEnterFrame(this);
               }
            }
         }
      }
      
      private function _fightClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_ui.data != null)
         {
            _loc2_ = int(FrameControllerManager.instance.guildFbController.model.configMaxFightNum);
            _loc4_ = int(FrameControllerManager.instance.guildFbController.model.currFightNum);
            _loc3_ = _loc2_ - _loc4_;
            if(_loc3_ <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("guildfb.nofightNum"));
               return;
            }
            control.requestOp(2,_ui.data.nodeID);
            dispose();
         }
      }
      
      private function get control() : GuildFbController
      {
         return FrameControllerManager.instance.guildFbController;
      }
      
      private function fightNodeChangeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GuildFBNode = param2 as GuildFBNode;
         _ui.setData(_loc3_);
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
         ObjectUtils.disposeObject(_ui);
         _ui = null;
         ObjectUtils.disposeObject(_fightPlayerView);
         _fightPlayerView = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __historyBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_fightPlayerView)
         {
            _fightPlayerView = ComponentFactory.Instance.creatComponentByStylename("consortia.view.fb.GuildFBFightInfoFrame");
            _fightPlayerView.addEventListener("dispose",__disposePlayerHandler);
            _fightPlayerView.show(this);
         }
         else
         {
            _fightPlayerView.dispose();
         }
      }
      
      private function __disposePlayerHandler(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("dispose",__disposePlayerHandler);
         _fightPlayerView = null;
      }
   }
}


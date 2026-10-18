package com.map.vehicle
{
   import chat.view.ChatBugleViewII;
   import chat.view.ChatInputViewII;
   import chat.view.ChatOutputViewII;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.ChatBar;
   import yishi.utils.MsgMan;
   
   public class VehicleChatController
   {
      
      private static const WIDTH:int = 380;
      
      private static var _instance:VehicleChatController;
      
      private var _bugleView:ChatBugleViewII;
      
      private var _input:ChatInputViewII;
      
      private var _output:ChatOutputViewII;
      
      private var _outputRect:Rectangle;
      
      private var _outputBarShowFlag:Boolean;
      
      private var started:Boolean;
      
      public function VehicleChatController()
      {
         super();
      }
      
      public static function getInstance() : VehicleChatController
      {
         if(!_instance)
         {
            _instance = new VehicleChatController();
         }
         return _instance;
      }
      
      private function addHandler() : void
      {
         StageReferance.stage.addEventListener("resize",layout);
         StageReferance.stage.addEventListener("keyDown",onKeyDown,false,50);
         _input.addEventListener("keyDown",onInputKeyDown,false,10);
         StageReferance.stage.addEventListener("mouseMove",onMouseMove);
         MsgMan.addObserver("yishi.datas.consant.BIG_BUGLE_EVENT",this,updateVbox);
      }
      
      private function updateVbox(param1:String, param2:Object) : void
      {
         layout(null);
      }
      
      private function removeHandler() : void
      {
         StageReferance.stage.removeEventListener("resize",layout);
         StageReferance.stage.removeEventListener("keyDown",onKeyDown);
         StageReferance.stage.removeEventListener("mouseMove",onMouseMove);
         if(_input)
         {
            _input.removeEventListener("keyDown",onInputKeyDown);
         }
         MsgMan.removeObserver("yishi.datas.consant.BIG_BUGLE_EVENT",this,updateVbox);
      }
      
      private function onInputKeyDown(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
         if(param1.keyCode == 13)
         {
            if(_input.visible)
            {
               _input.visible = false;
            }
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            if(!_input.visible)
            {
               _input.visible = true;
               StageReferance.stage.focus = _input.inputText;
            }
            else if(_input.inputText.text == "")
            {
               switchInputVisible();
            }
            param1.stopImmediatePropagation();
         }
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Array = [ChatBar.instance.buttonBox,_output.cleanBtn,_output.back,_output.toBottomBtn,_output.chatList.vScrollbar];
         var _loc3_:Boolean = _outputRect.contains(StageReferance.stage.mouseX,StageReferance.stage.mouseY);
         if(_loc3_)
         {
            if(!_outputBarShowFlag)
            {
               TweenMax.allTo(_loc2_,0.3,{
                  "alpha":1,
                  "onComplete":stop
               });
               _outputBarShowFlag = true;
            }
         }
         else if(_outputBarShowFlag)
         {
            TweenMax.allTo(_loc2_,0.3,{
               "alpha":0,
               "onComplete":stop
            });
            _outputBarShowFlag = false;
         }
      }
      
      private function stop() : void
      {
         TweenMax.killTweensOf(ChatBar.instance.buttonBox);
         TweenMax.killTweensOf(_output.cleanBtn);
         TweenMax.killTweensOf(_output.back);
         TweenMax.killTweensOf(_output.toBottomBtn);
         TweenMax.killTweensOf(_output.chatList.vScrollbar);
      }
      
      public function switchInputVisible() : void
      {
         _input.visible = !_input.visible;
         if(_input.visible)
         {
            StageReferance.stage.focus = _input.inputText;
         }
         else
         {
            _input.closeChannel();
         }
      }
      
      private function layout(param1:Event = null) : void
      {
         var _loc2_:int = StageReferance.stageWidth;
         var _loc3_:int = StageReferance.stageHeight;
         _input.x = _loc2_ - _input.width >> 1;
         _input.y = _loc3_ - 230;
         _bugleView.x = 0;
         _bugleView.y = 5;
         _output.x = 0;
         _output.y = _bugleView.y + _bugleView.viewRectangle.height;
         _outputRect = new Rectangle(1,_output.y,280,150);
         _outputRect.width += 32;
      }
      
      public function start() : void
      {
         if(!ChatBar.instance.isLoaded)
         {
            ChatBar.instance.show(start);
            return;
         }
         started = true;
         _bugleView = ChatBar.instance.chatBugleView;
         _input = ChatBar.instance.chatInputView;
         _output = ChatBar.instance.chatOutPutView;
         LayerManager.Instance.addToLayer(_bugleView,4,false,false,0,0);
         LayerManager.Instance.addToLayer(_input,4,false,false,0,2);
         LayerManager.Instance.addToLayer(_output,4,false,false,0,0);
         _input.visible = false;
         _output.showMinView(true);
         _output.cleanBtn.visible = true;
         _output.cleanBtn.alpha = 0;
         ChatBar.instance.upBtn.visible = false;
         ChatBar.instance.downBtn.visible = false;
         ChatBar.instance.buttonBox.alpha = 0;
         ChatBar.instance.buttonBox.x = 24;
         _output.back.alpha = 0;
         _output.toBottomBtn.alpha = 0;
         _output.chatList.vScrollbar.alpha = 0;
         layout();
         addHandler();
         StageReferance.stage.focus = StageReferance.stage;
      }
      
      public function dispose() : void
      {
         if(!started)
         {
            return;
         }
         started = false;
         TweenMax.killTweensOf(ChatBar.instance.buttonBox);
         removeHandler();
         if(ChatBar.instance.isMinShow)
         {
            _output.showMinView();
         }
         else
         {
            _output.showMaxView();
         }
         if(_bugleView.parent)
         {
            _bugleView.parent.removeChild(_bugleView);
         }
         if(_input.parent)
         {
            _input.parent.removeChild(_input);
         }
         if(_output.parent)
         {
            _output.parent.removeChild(_output);
         }
         _input.visible = true;
         ChatBar.instance.upBtn.visible = true;
         ChatBar.instance.downBtn.visible = true;
         ChatBar.instance.buttonBox.spacing = 1;
         ChatBar.instance.buttonBox.alpha = 1;
         ChatBar.instance.buttonBox.x = 7;
         _output.cleanBtn.visible = false;
         _output.cleanBtn.alpha = 1;
         _output.back.alpha = 1;
         _output.toBottomBtn.alpha = 1;
         _output.chatList.vScrollbar.alpha = 1;
      }
   }
}


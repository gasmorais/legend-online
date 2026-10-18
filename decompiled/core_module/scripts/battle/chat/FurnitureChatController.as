package battle.chat
{
   import chat.view.ChatBugleViewII;
   import chat.view.ChatInputViewII;
   import chat.view.ChatOutputViewII;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mainBar.ChatBar;
   import managers.HomeManager;
   import yishi.utils.MsgMan;
   
   public class FurnitureChatController
   {
      
      private static const WIDTH:int = 380;
      
      private static var _instance:FurnitureChatController;
      
      private var _bugleView:ChatBugleViewII;
      
      private var _input:ChatInputViewII;
      
      private var _output:ChatOutputViewII;
      
      private var _outputRect:Rectangle;
      
      private var _outputBarShowFlag:Boolean;
      
      public var container:Sprite;
      
      public function FurnitureChatController()
      {
         super();
      }
      
      public static function getInstance() : FurnitureChatController
      {
         if(!_instance)
         {
            _instance = new FurnitureChatController();
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
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Array = [ChatBar.instance.buttonBox,_output.cleanBtn,_output.back,_output.chatList.vScrollbar,_output.toBottomBtn];
         var _loc3_:Boolean = _outputRect.contains(container.mouseX,container.mouseY);
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
         TweenMax.killTweensOf(_output.chatList.vScrollbar);
         TweenMax.killTweensOf(_output.toBottomBtn);
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
      
      public function switchInputVisible() : void
      {
         _input.visible = !_input.visible;
         if(_input.visible)
         {
            StageReferance.stage.focus = _input.inputText;
         }
      }
      
      private function layout(param1:Event = null) : void
      {
         if(HomeManager.instance.model.inFixUp)
         {
            _bugleView.x = 0;
            _bugleView.y = 85;
         }
         else
         {
            _bugleView.x = 0;
            _bugleView.y = 5;
         }
         _output.x = 0;
         _output.y = _bugleView.y + _bugleView.viewRectangle.height;
         _input.y = _output.y + 160;
         _outputRect = new Rectangle(1,_output.y,280,150);
         _outputRect.width += 32;
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
      
      public function adjustEquipTipPos(param1:DisplayObject) : void
      {
         var _loc2_:Point = new Point(_output.width + 20,0);
         _loc2_ = container.localToGlobal(_loc2_);
         param1.x = container.x + _output.width + 20;
         param1.y = container.y + _output.y;
      }
      
      public function start() : void
      {
         if(!ChatBar.instance.isLoaded)
         {
            ChatBar.instance.show(start);
            return;
         }
         _bugleView = ChatBar.instance.chatBugleView;
         _input = ChatBar.instance.chatInputView;
         _output = ChatBar.instance.chatOutPutView;
         container.addChild(_bugleView);
         container.addChild(_input);
         container.addChild(_output);
         _input.visible = false;
         _output.showMinView(true);
         _output.cleanBtn.visible = true;
         _output.cleanBtn.alpha = 0;
         ChatBar.instance.upBtn.visible = false;
         ChatBar.instance.downBtn.visible = false;
         ChatBar.instance.buttonBox.alpha = 0;
         ChatBar.instance.buttonBox.x = 24;
         ChatBar.instance.chatOutPutView.back.alpha = 0;
         ChatBar.instance.chatOutPutView.chatList.vScrollbar.alpha = 0;
         ChatBar.instance.chatOutPutView.toBottomBtn.alpha = 0;
         layout();
         addHandler();
         StageReferance.stage.focus = StageReferance.stage;
      }
      
      public function dispose() : void
      {
         TweenMax.killTweensOf(ChatBar.instance.buttonBox);
         if(_output)
         {
            TweenMax.killTweensOf(_output.cleanBtn);
            TweenMax.killTweensOf(_output.chatList.vScrollbar);
            TweenMax.killTweensOf(_output.toBottomBtn);
            TweenMax.killTweensOf(_output.back);
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
            _output.chatList.vScrollbar.alpha = 1;
            _output.back.alpha = 1;
            _output.toBottomBtn.alpha = 1;
         }
      }
   }
}


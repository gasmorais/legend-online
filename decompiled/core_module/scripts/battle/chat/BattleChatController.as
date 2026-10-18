package battle.chat
{
   import battle.BattleManager;
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
   import yishi.utils.MsgMan;
   
   public class BattleChatController
   {
      
      private static const WIDTH:int = 380;
      
      private static var _instance:BattleChatController;
      
      private var _bugleView:ChatBugleViewII;
      
      private var _input:ChatInputViewII;
      
      private var _output:ChatOutputViewII;
      
      private var _outputRect:Rectangle;
      
      private var _outputBarShowFlag:Boolean;
      
      public function BattleChatController()
      {
         super();
      }
      
      public static function getInstance() : BattleChatController
      {
         if(!_instance)
         {
            _instance = new BattleChatController();
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
         var _loc3_:Array = [ChatBar.instance.buttonBox,_output.cleanBtn,_output.back,_output.chatList.vScrollbar,_output.toBottomBtn];
         var _loc2_:Sprite = BattleManager.getInstance().battleUIView;
         var _loc4_:Boolean = _outputRect.contains(_loc2_.mouseX,_loc2_.mouseY);
         if(_loc4_)
         {
            if(!_outputBarShowFlag)
            {
               TweenMax.allTo(_loc3_,0.3,{
                  "alpha":1,
                  "onComplete":stop
               });
               _outputBarShowFlag = true;
            }
         }
         else if(_outputBarShowFlag)
         {
            TweenMax.allTo(_loc3_,0.3,{
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
         var _loc2_:Number = BattleManager.getInstance().mainViewContainer.view.sceneWidth / 1300;
         _bugleView.x = 0;
         _bugleView.y = 5;
         _input.x = (BattleManager.getInstance().mainViewContainer.view.sceneWidth - _input.width) * 0.5;
         _input.y = BattleManager.getInstance().mainViewContainer.view.sceneHeight - 230 * _loc2_;
         _output.x = 0;
         _output.y = _bugleView.y + _bugleView.viewRectangle.height;
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
      
      public function start() : void
      {
         if(!ChatBar.instance.isLoaded)
         {
            if(ChatBar.instance)
            {
               ChatBar.instance.show(start);
            }
            return;
         }
         _bugleView = ChatBar.instance.chatBugleView;
         _input = ChatBar.instance.chatInputView;
         _output = ChatBar.instance.chatOutPutView;
         BattleManager.getInstance().battleUIView.addChild(_bugleView);
         BattleManager.getInstance().battleUIView.addChild(_input);
         BattleManager.getInstance().battleUIView.addChild(_output);
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
         _bugleView = null;
         _input = null;
         _output = null;
      }
      
      public function adjustEquipTipPos(param1:DisplayObject) : void
      {
         var _loc2_:* = BattleManager.getInstance().mainViewContainer.view;
         var _loc3_:Point = new Point(_loc2_.x + _output.width + 20,_loc2_.y);
         _loc3_ = BattleManager.getInstance().battleUIView.localToGlobal(_loc3_);
         param1.x = _loc2_.x + _output.width + 20;
         param1.y = _loc2_.y + _output.y;
      }
   }
}


package chat.view
{
   import chat.datas.ExpressionItemData;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.manager.NotificationManager;
   
   public class ExpressionList extends Sprite implements Disposeable
   {
      
      private var _back:Scale9CornerImage;
      
      private var _cutOffRule:MutipleImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _expressionContainer:Sprite;
      
      private var _input:FilterFrameText;
      
      private var ignoreList:Array = [25,36];
      
      public function ExpressionList()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("chatII.ExpressionList.ExpressionPanelBg");
         _cutOffRule = ComponentFactory.Instance.creatComponentByStylename("chatII.ExpressionList.ExpressionCutOffRule");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("chatII.ExpressionList.NameTxt");
         addChild(_back);
         addChild(_cutOffRule);
         addChild(_nameTxt);
         _expressionContainer = new Sprite();
         _expressionContainer.x = 7;
         _expressionContainer.y = 7;
         addChild(_expressionContainer);
         initExpressionListView();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_cutOffRule);
         _cutOffRule = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeAllChildren(this);
         _input = null;
      }
      
      private function initEvents() : void
      {
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
      }
      
      private function removeEvents() : void
      {
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
      }
      
      private function __switchSceneHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function initExpressionListView() : void
      {
         var _loc1_:ExpressionItem = null;
         var _loc2_:ExpressionItemData = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:String = "";
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < 40)
         {
            if(ignoreList.indexOf(_loc6_) == -1)
            {
               if(_loc6_ < 10)
               {
                  _loc4_ = "0" + _loc6_.toString();
               }
               else
               {
                  _loc4_ = _loc6_.toString();
               }
               _loc7_ = _loc5_ / 10;
               _loc3_ = _loc5_ % 10;
               _loc1_ = new ExpressionItem();
               _loc1_.x = _loc3_ * 27 + 1;
               _loc1_.y = _loc7_ * 27 + 1;
               _loc2_ = new ExpressionItemData();
               _loc2_.eindex = _loc4_;
               _loc2_.ename = LanguageMgr.GetTranslation("chat.view.ExpressionList.Ename" + _loc4_);
               _loc2_.eroll = setNameTxt;
               _loc2_.eclick = selectExpression;
               _loc1_.data = _loc2_;
               _expressionContainer.addChild(_loc1_);
               _loc5_++;
            }
            _loc6_++;
         }
      }
      
      private function setNameTxt(param1:String = "") : void
      {
         if(_nameTxt != null)
         {
            _nameTxt.text = param1;
         }
      }
      
      private function selectExpression(param1:String) : void
      {
         if(_input != null)
         {
            _input.appendText("#" + param1);
            checkLength();
            StageReferance.stage.focus = _input;
         }
         dispose();
      }
      
      private function checkLength() : void
      {
         var _loc1_:int = _input.text.length;
         if(_loc1_ > 38)
         {
            _input.text = _input.text.substr(0,38);
         }
         _input.setSelection(_loc1_,_loc1_);
      }
      
      public function set input(param1:FilterFrameText) : void
      {
         _input = param1;
      }
      
      public function dispose() : void
      {
         removeEvents();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("dispose"));
      }
   }
}


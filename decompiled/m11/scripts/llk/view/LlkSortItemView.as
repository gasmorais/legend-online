package llk.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.llk.LlkSortData;
   
   public class LlkSortItemView extends Sprite implements Disposeable
   {
      
      private var _data:LlkSortData;
      
      private var _orderTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gateTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _appellTxt:FilterFrameText;
      
      private var _topIcon:ScaleFrameImage;
      
      public function LlkSortItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _orderTxt = ComponentFactory.Instance.creatComponentByStylename("PetChallengeTopListItemView.rankingTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("PetChallengeTopListItemView.scoreTxt");
         _gateTxt = ComponentFactory.Instance.creatComponentByStylename("PetChallengeTopListItemView.severTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("PetChallengeTopListItemView.nameTxt");
         _appellTxt = ComponentFactory.Instance.creatComponentByStylename("LlkSortItemView.appellTxt");
         _topIcon = ComponentFactory.Instance.creatComponentByStylename("LlkSortItemView.TopIcon");
         addChild(_orderTxt);
         addChild(_nameTxt);
         addChild(_gateTxt);
         addChild(_scoreTxt);
         addChild(_appellTxt);
         addChild(_topIcon);
      }
      
      private function uninitView() : void
      {
         _data = null;
         ObjectUtils.disposeObject(_orderTxt);
         _orderTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gateTxt);
         _gateTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_appellTxt);
         _appellTxt = null;
         ObjectUtils.disposeObject(_topIcon);
         _topIcon = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__lookinfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__lookinfoHandler);
      }
      
      private function __lookinfoHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
      }
      
      public function get data() : LlkSortData
      {
         return _data;
      }
      
      public function set data(param1:LlkSortData) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            refresh();
         }
      }
      
      private function clean() : void
      {
         _orderTxt.text = "";
         _scoreTxt.text = "";
         _gateTxt.text = "";
         _nameTxt.text = "";
         _appellTxt.text = "";
         _topIcon.visible = false;
      }
      
      private function refresh() : void
      {
         _orderTxt.text = _data.order.toString();
         _scoreTxt.text = _data.score.toString();
         _gateTxt.text = _data.gate.toString();
         _nameTxt.text = _data.nickName;
         _appellTxt.text = _data.appell;
         if(_data.order >= 1 && _data.order <= 3)
         {
            _topIcon.setFrame(_data.order);
            _topIcon.visible = true;
            _orderTxt.visible = false;
         }
         else
         {
            _topIcon.visible = false;
            _orderTxt.visible = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


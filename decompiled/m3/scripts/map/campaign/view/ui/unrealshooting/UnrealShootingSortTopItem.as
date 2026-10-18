package map.campaign.view.ui.unrealshooting
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import map.campaign.data.UnrealShootingUserInfo;
   
   public class UnrealShootingSortTopItem extends Sprite implements Disposeable
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _data:UnrealShootingUserInfo;
      
      public function UnrealShootingSortTopItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopItem.RankTxt");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopItem.NickNameTxt");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopItem.PointTxt");
         addChild(_rankTxt);
         addChild(_nickNameTxt);
         addChild(_pointTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : UnrealShootingUserInfo
      {
         return _data;
      }
      
      public function set data(param1:UnrealShootingUserInfo) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            _rankTxt.text = data.rank + ".";
            _nickNameTxt.text = data.nickName;
            _pointTxt.text = data.score.toString();
         }
      }
      
      private function clean() : void
      {
         _rankTxt.text = "";
         _nickNameTxt.text = "";
         _pointTxt.text = "";
      }
      
      public function setFrame(param1:int) : void
      {
         _nickNameTxt.setFrame(param1);
         _pointTxt.setFrame(param1);
         _rankTxt.setFrame(param1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}


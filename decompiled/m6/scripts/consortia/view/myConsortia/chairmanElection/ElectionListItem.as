package consortia.view.myConsortia.chairmanElection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.consortia.ConsortiaVotingUserInfo;
   
   public class ElectionListItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _checkBox:SelectedButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _data:ConsortiaVotingUserInfo;
      
      public function ElectionListItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionListItemBg");
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("consortia.SelectButton");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionItemNameTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionItemNumTxt");
         addChild(_bg);
         addChild(_checkBox);
         addChild(_nameTxt);
         addChild(_numTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_checkBox);
         _checkBox = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get data() : ConsortiaVotingUserInfo
      {
         return _data;
      }
      
      public function set data(param1:ConsortiaVotingUserInfo) : void
      {
         if(_data != param1)
         {
            _data = param1;
            _nameTxt.text = data.nickName;
            _numTxt.text = String(data.votingData);
         }
      }
      
      public function get checkBox() : SelectedButton
      {
         return _checkBox;
      }
      
      public function set checkBox(param1:SelectedButton) : void
      {
         _checkBox = param1;
      }
   }
}


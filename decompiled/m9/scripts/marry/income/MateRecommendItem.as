package marry.income
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.friends.RecommendInfo;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.manager.FriendManager;
   
   public class MateRecommendItem extends Sprite implements Disposeable
   {
      
      private var _index:int;
      
      private var _selected:Boolean = false;
      
      private var _background:ScaleFrameImage;
      
      private var _sexBG:ScaleFrameImage;
      
      private var _itemSelectBG:Image;
      
      private var _idtxt:FilterFrameText;
      
      private var _nametxt:FilterFrameText;
      
      private var _LVtxt:FilterFrameText;
      
      private var _powertxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _heartIcon:Bitmap;
      
      private var _data:RecommendInfo;
      
      private var _frameFilter:Array;
      
      public function MateRecommendItem()
      {
         super();
         initView();
         initEvents();
      }
      
      public function get data() : RecommendInfo
      {
         return _data;
      }
      
      public function set data(param1:RecommendInfo) : void
      {
         _data = param1;
         updata();
      }
      
      private function refreshVocation() : void
      {
         var _loc1_:SimplePlayerInfo = null;
         if(_data && _data.vocationGrades > 0)
         {
            _loc1_ = new SimplePlayerInfo();
            _loc1_.vocationGrades = _data.vocationGrades;
            _loc1_.vocationIndex = _data.vocationIndex;
            _heartIcon.visible = true;
         }
         else
         {
            _heartIcon.visible = false;
         }
      }
      
      private function initView() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("marry.YieldItemBack");
         _background.width = 497;
         _idtxt = ComponentFactory.Instance.creatComponentByStylename("marry.RecommendItemIDTxt");
         _nametxt = ComponentFactory.Instance.creatComponentByStylename("marry.RecommendItemNameTxt");
         _LVtxt = ComponentFactory.Instance.creatComponentByStylename("marry.RecommendItemLVTxt");
         _powertxt = ComponentFactory.Instance.creatComponentByStylename("marry.RecommendItemPowerTxt");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("marry.RecommentAddFriend");
         _itemSelectBG = ComponentFactory.Instance.creatComponentByStylename("marry.RecommendpageBg");
         _sexBG = ComponentFactory.Instance.creatComponentByStylename("marry.RecommendIconBG");
         _heartIcon = ComponentFactory.Instance.creatBitmap("asset.marry.heartImg");
         addChild(_background);
         addChild(_idtxt);
         addChild(_nametxt);
         addChild(_LVtxt);
         addChild(_powertxt);
         addChild(_addBtn);
         addChild(_itemSelectBG);
         addChild(_sexBG);
         addChild(_heartIcon);
         _addBtn.visible = false;
         _sexBG.visible = false;
         _itemSelectBG.visible = false;
         _itemSelectBG.mouseEnabled = _itemSelectBG.mouseChildren = false;
         _heartIcon.visible = false;
      }
      
      private function initEvents() : void
      {
         _addBtn.addEventListener("click",_addClick);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",_over);
         removeEventListener("mouseOut",_out);
         _addBtn.removeEventListener("click",_addClick);
      }
      
      private function _addClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(FriendManager.getInstance().sendAddFriendRequest(_nametxt.text,1))
         {
            isAddFriend = false;
         }
      }
      
      public function set index(param1:int) : void
      {
         _index = param1 + 1;
         _background.setFrame(_index % 2 + 1);
      }
      
      private function clean() : void
      {
         _idtxt.text = "";
         _nametxt.text = "";
         _LVtxt.text = "";
         _powertxt.text = "";
         _addBtn.visible = false;
         _sexBG.visible = false;
         _itemSelectBG.visible = false;
         buttonMode = false;
         _itemSelectBG.width = 506;
         _itemSelectBG.mouseEnabled = _itemSelectBG.mouseChildren = false;
         removeEventListener("mouseOver",_over);
         removeEventListener("mouseOut",_out);
         filters = _frameFilter[2];
      }
      
      private function updata() : void
      {
         clean();
         if(_data)
         {
            _idtxt.text = String(_index);
            _nametxt.text = _data.name;
            _LVtxt.text = "x" + _data.level.toString();
            _sexBG.setFrame(_data.sex + 1);
            _powertxt.text = _data.attack.toString();
            _addBtn.visible = true;
            _addBtn.enable = true;
            _sexBG.visible = true;
            buttonMode = true;
            _heartIcon.visible = true;
            addEventListener("mouseOver",_over);
            addEventListener("mouseOut",_out);
         }
      }
      
      public function set filterString(param1:String) : void
      {
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(param1);
      }
      
      public function _over(param1:MouseEvent) : void
      {
         _itemSelectBG.visible = true;
         filters = _frameFilter[1];
      }
      
      public function _out(param1:MouseEvent) : void
      {
         _itemSelectBG.visible = selected;
         filters = _frameFilter[2];
      }
      
      public function set isAddFriend(param1:Boolean) : void
      {
         _addBtn.enable = param1;
      }
      
      public function get isAddFriend() : Boolean
      {
         return _addBtn.enable;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _itemSelectBG.visible = _selected && _data != null;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      override public function get height() : Number
      {
         return _background.height;
      }
      
      public function get addBtn() : BaseButton
      {
         return _addBtn;
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
         }
         _background = null;
         if(_idtxt)
         {
            ObjectUtils.disposeObject(_idtxt);
         }
         _idtxt = null;
         if(_nametxt)
         {
            ObjectUtils.disposeObject(_nametxt);
         }
         _nametxt = null;
         if(_LVtxt)
         {
            ObjectUtils.disposeObject(_LVtxt);
         }
         _LVtxt = null;
         if(_sexBG)
         {
            ObjectUtils.disposeObject(_sexBG);
         }
         _sexBG = null;
         if(_powertxt)
         {
            ObjectUtils.disposeObject(_powertxt);
         }
         _powertxt = null;
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
         }
         _addBtn = null;
         if(_heartIcon)
         {
            ObjectUtils.disposeObject(_heartIcon);
         }
         _heartIcon = null;
         if(_itemSelectBG)
         {
            ObjectUtils.disposeObject(_itemSelectBG);
         }
         _itemSelectBG = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


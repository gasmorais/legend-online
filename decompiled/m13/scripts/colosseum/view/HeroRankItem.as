package colosseum.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PlayerMenu;
   
   public class HeroRankItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _back:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _combatTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _data:ThaneInfo;
      
      public function HeroRankItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankItemBack");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankValueTxt");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankNameValueTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankLevelValueTxt");
         _combatTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankCombatValueTxt");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("colosseum.VocationIcon");
         _vocationIcon.visible = false;
         addChild(_back);
         _back.setFrame(1);
         addChild(_rankTxt);
         addChild(_nickNameTxt);
         addChild(_levelTxt);
         addChild(_combatTxt);
         addChild(_vocationIcon);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = parent.localToGlobal(new Point(x,y + 20));
         var _loc2_:PlayerMenu = new PlayerMenu();
         _loc2_.setData(data);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         LayerManager.Instance.addToLayer(_loc2_,7);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_selected || !_data)
         {
            return;
         }
         _back.setFrame(2);
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_selected || !_data)
         {
            return;
         }
         _back.setFrame(1);
      }
      
      private function refreshVocation() : void
      {
         if(_data && _data.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_data.templateInfo.Job,_data.vocationStep,_data.vocationLevel);
            _vocationIcon.setFrame(_data.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         _rankTxt.text = _data.challengeRank.toString();
         _nickNameTxt.text = _data.nickName;
         _levelTxt.text = _data.grades.toString();
         _combatTxt.text = _data.fightingCapacity.toString();
         setVipIcon();
         if(isVip)
         {
            _nickNameTxt.visible = false;
            _vipIcon.visible = true;
            _vipText.visible = true;
         }
         else
         {
            _nickNameTxt.visible = true;
            _vipIcon.visible = false;
            _vipText.visible = false;
         }
         refreshVocation();
      }
      
      private function get isVip() : Boolean
      {
         return _data.IsVipAndNoExpirt;
      }
      
      private function setVipIcon() : void
      {
         var _loc1_:TextField = null;
         if(!_vipIcon)
         {
            _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
            addChild(_vipIcon);
         }
         _vipIcon.x = 68;
         _vipIcon.y = _nickNameTxt.y + 1;
         if(!_vipText)
         {
            _vipText = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankNameGradientText");
            addChild(_vipText);
            _loc1_ = new TextField();
            _vipText.text = _nickNameTxt.text;
         }
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected)
         {
            _back.setFrame(2);
         }
         else
         {
            _back.setFrame(1);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_combatTxt);
         _combatTxt = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
   }
}


package sort.shoubang
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.sort.SortData;
   import yishi.manager.PlayerInfoManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class ShouBangItem extends Component
   {
      
      private var _headbg:MovieClip;
      
      private var _chengweibg:DisplayObject;
      
      private var _namebg:DisplayObject;
      
      private var _playerId:int;
      
      private var _head:int;
      
      private var _chegnwei:int;
      
      private var _playerName:String;
      
      private var _isVip:Boolean;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipIcon:Bitmap;
      
      private var _nameC:Sprite;
      
      private var _vipnameTxt:GradientText;
      
      private var _blank:Boolean = false;
      
      private var _data:SortData;
      
      public function ShouBangItem()
      {
         super();
         this.buttonMode = true;
         initUI();
         addEvents();
      }
      
      private function initUI() : void
      {
         _headbg = ComponentFactory.Instance.creatCustomObject("sort.numberone.headbg");
         this.addChild(_headbg);
         _icon = ComponentFactory.Instance.creatCustomObject("resoueceBar.PlayerIcon");
         _headbg.headC.addChild(_icon);
         _nameC = new Sprite();
         this.addChild(_nameC);
         _nameC.x = -11;
         _nameC.y = 101;
      }
      
      public function blankHead(param1:int) : void
      {
         _blank = true;
         if(_chengweibg)
         {
            ObjectUtils.disposeObject(_chengweibg);
            _chengweibg = null;
         }
         var _loc2_:String = "asset.shoubang.chenghao" + param1;
         _chengweibg = ComponentFactory.Instance.creat(_loc2_);
         this.addChild(_chengweibg);
         _chengweibg.x = -12;
         _chengweibg.y = -35;
         _headbg.headBlank.visible = true;
         if(_icon != null)
         {
            _icon.visible = false;
         }
         _nameC.visible = false;
         if(_nameTxt != null)
         {
            _nameTxt.visible = false;
         }
         if(_vipnameTxt == null)
         {
            _vipnameTxt = ComponentFactory.Instance.creatComponentByStylename("sort.numberone.ItemTextStyle_vip");
         }
         if(_vipnameTxt.parent)
         {
            _vipnameTxt.parent.removeChild(_vipnameTxt);
         }
         this.addChild(_vipnameTxt);
         if(!_vipnameTxt.visible)
         {
            _vipnameTxt.visible = true;
         }
         _vipnameTxt.text = LanguageMgr.GetTranslation("sort.shoubang.blankhead");
         _vipnameTxt.x = -11 + (120 - _vipnameTxt.textWidth) * 0.5;
         _vipnameTxt.y = 101;
      }
      
      public function updateData(param1:SortData, param2:int) : void
      {
         _blank = false;
         _data = param1;
         _headbg.headBlank.visible = false;
         _playerId = param1.army.userId;
         _head = param1.army.baseHero.snsInfo.headId;
         _chegnwei = param2;
         _playerName = param1.nikcName;
         _isVip = param1.army.baseHero.IsVipAndNoExpirt;
         _icon.visible = true;
         var _loc3_:String = IconFactory.getPlayerIcon(_head,"head");
         _icon.icon = _loc3_;
         if(_chengweibg)
         {
            ObjectUtils.disposeObject(_chengweibg);
            _chengweibg = null;
         }
         var _loc4_:String = "asset.shoubang.chenghao" + _chegnwei;
         _chengweibg = ComponentFactory.Instance.creat(_loc4_);
         this.addChild(_chengweibg);
         _chengweibg.x = -2;
         _chengweibg.y = -35;
         if(_isVip)
         {
            _nameC.visible = true;
            if(_vipIcon == null)
            {
               _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
               _nameC.addChild(_vipIcon);
               _vipIcon.y = 2;
            }
            if(_vipnameTxt == null)
            {
               _vipnameTxt = ComponentFactory.Instance.creatComponentByStylename("sort.numberone.ItemTextStyle_vip");
               _nameC.addChild(_vipnameTxt);
            }
            if(!_vipnameTxt.visible)
            {
               _vipnameTxt.visible = true;
            }
            _vipnameTxt.x = 20;
            _vipnameTxt.y = 0;
            if(_vipnameTxt.parent == null)
            {
               _nameC.addChild(_vipnameTxt);
            }
            else
            {
               _vipnameTxt.parent.removeChild(_vipnameTxt);
               _nameC.addChild(_vipnameTxt);
            }
            _vipnameTxt.text = _playerName;
            _nameC.x = -11 + (120 - _vipnameTxt.textWidth - 20) * 0.5;
            if(_nameTxt != null)
            {
               _nameTxt.visible = false;
            }
         }
         else
         {
            if(_nameTxt == null)
            {
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("sort.numberone.ItemTextStyle");
               this.addChild(_nameTxt);
            }
            _nameTxt.visible = true;
            _nameTxt.text = _playerName;
            if(_nameC != null)
            {
               _nameC.visible = false;
            }
            if(_vipnameTxt != null)
            {
               _vipnameTxt.visible = false;
            }
         }
      }
      
      private function addEvents() : void
      {
         this.addEventListener("click",clickHandler);
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseTip = null;
         if(_blank)
         {
            return;
         }
         if(_chegnwei == 6)
         {
            _loc2_ = ComponentFactory.Instance.creat("yishi.view.tips.PetCompareTip");
            _loc2_.tipData = _data.petData;
            _loc2_.x = StageReferance.stage.mouseX + 20;
            _loc2_.y = StageReferance.stage.mouseY;
            LayerManager.Instance.addToLayer(_loc2_,7);
         }
         else
         {
            PlayerInfoManager.instance.show(_data,0);
         }
      }
      
      private function removeEvents() : void
      {
         this.removeEventListener("click",clickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_headbg);
         _headbg = null;
         ObjectUtils.disposeObject(_chengweibg);
         _chengweibg = null;
         ObjectUtils.disposeObject(_namebg);
         _namebg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_nameC);
         _nameC = null;
         ObjectUtils.disposeObject(_vipnameTxt);
         _vipnameTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


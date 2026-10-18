package bag360
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.privilege.PrivilegeMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.Bag360Manager;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.Bag360Template;
   import yishi.filter.UIFilter;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class Bag360Item extends Sprite implements Disposeable, IManualSize
   {
      
      private var _levelContain:Sprite;
      
      private var _levelBmp:Bitmap;
      
      private var _levelText:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _btn:IconButton;
      
      private var _receivedIcon:Image;
      
      private var _index:int;
      
      private var _state:int;
      
      private var _dropTemps:Array;
      
      private var _isDie:Boolean = false;
      
      public function Bag360Item()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,100,43);
      }
      
      private function initView() : void
      {
         _levelContain = new Sprite();
         _levelText = ComponentFactory.Instance.creatComponentByStylename("bag360.Item.Txt");
         _levelBmp = ComponentFactory.Instance.creatBitmap("asset.bag360.levelBmp");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("bag360.Item.Contain");
         _btn = ComponentFactory.Instance.creatComponentByStylename("bag360.Item.Btn");
         _receivedIcon = ComponentFactory.Instance.creatComponentByStylename("bag360.CountedTxt_2");
         addChild(_levelContain);
         addChild(_levelText);
         addChild(_hBox);
         addChild(_btn);
         addChild(_receivedIcon);
         _levelContain.x = 6;
         _levelContain.y = 13;
         _levelText.text = LanguageMgr.GetTranslation("public.level");
         _receivedIcon.mouseEnabled = _receivedIcon.mouseChildren = false;
         _receivedIcon.visible = false;
      }
      
      private function initEvent() : void
      {
         if(_btn)
         {
            _btn.addEventListener("click",__clickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_state != 1)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(8722);
         var _loc2_:PrivilegeMsg = new PrivilegeMsg();
         _loc2_.index = _index;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         NumberViewUtils.getNumberView(levelDic[param1],_levelContain,_levelBmp.bitmapData,24,27,23,24,"0123456789",1);
         _levelContain.scaleX = 0.7;
         _levelContain.scaleY = 0.7;
         if(_index == 1)
         {
            _levelContain.x = 16;
         }
         refreshView();
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_isDie)
         {
            return;
         }
         switch(_state - 1)
         {
            case 0:
               _receivedIcon.visible = false;
               _btn.visible = true;
               _btn.enable = true;
               break;
            case 1:
               _receivedIcon.visible = false;
               _btn.visible = true;
               _btn.enable = false;
               break;
            case 2:
               _receivedIcon.visible = true;
               _btn.visible = false;
         }
         refreshDrop();
      }
      
      private function refreshDrop() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Bag360Template = null;
         var _loc4_:GoodsInfo = null;
         var _loc1_:BaseItemView = null;
         ObjectUtils.disposeAllChildren(_hBox);
         if(!_dropTemps)
         {
            _dropTemps = TempleteManager.instance.bag360DropTemplateCate.getTemplatesByIndex(_index);
         }
         _loc2_ = 0;
         while(_loc2_ < _dropTemps.length)
         {
            _loc3_ = _dropTemps[_loc2_] as Bag360Template;
            if(_loc3_.Job.indexOf(job) >= 0)
            {
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = _loc3_.ItemId;
               _loc4_.count = _loc3_.Count;
               _loc1_ = ComponentFactory.Instance.creatCustomObject("countlogin.DropItem");
               _loc1_.data = _loc4_;
               _hBox.addChild(_loc1_);
            }
            _loc2_++;
         }
         if(_state == 1)
         {
            _hBox.filters = null;
         }
         else
         {
            _hBox.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      private function get levelDic() : Dictionary
      {
         return Bag360Manager.instance.levelDic;
      }
      
      private function get job() : String
      {
         var _loc1_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.job);
         switch(_loc1_ - 1)
         {
            case 0:
            case 3:
               return "1";
            case 1:
            case 4:
               return "2";
            case 2:
            case 5:
               return "3";
            default:
               return "0";
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         if(_isDie)
         {
            return;
         }
         _isDie = true;
         removeEvent();
         if(_btn)
         {
            _btn.dispose();
         }
         _btn = null;
         if(_receivedIcon)
         {
            _receivedIcon.dispose();
         }
         _receivedIcon = null;
         ObjectUtils.disposeObject(_levelBmp);
         ObjectUtils.disposeObject(_levelText);
         ObjectUtils.disposeObject(_levelText);
         _levelContain = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


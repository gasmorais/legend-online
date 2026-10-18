package worldboss.pvp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import net.SingWarSocketSendManager;
   import worldboss.EnterBaseItemView;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class WarFightItem extends EnterBaseItemView
   {
      
      private var _bg:Bitmap;
      
      private var _btn:IconButton;
      
      private var _icon:BaseIconView;
      
      private var _mapName:FilterFrameText;
      
      private var _openTxt:FilterFrameText;
      
      private var _openTimeTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _iconBack:ScaleBitmapImage;
      
      public var campaignId:int;
      
      public function WarFightItem()
      {
         super();
         state = 100000;
         init();
      }
      
      public function setDataTemp(param1:int, param2:String, param3:int, param4:String, param5:String, param6:String = "") : void
      {
         campaignId = param1;
         state = param3;
         updateState();
         _mapName.text = param2;
         _openTxt.text = LanguageMgr.GetTranslation("worldboss.pvp.WarFightItem.open");
         _openTimeTxt.text = param4 + "-" + param5;
         _descTxt.text = param6;
         _icon.icon = IconFactory.getPvpWarFight(campaignId);
      }
      
      override public function updateState() : void
      {
         if(state == 0)
         {
            _btn.visible = true;
            _iconBack.visible = true;
            if(_openTxt.parent)
            {
               _openTxt.parent.removeChild(_openTxt);
            }
            if(_openTimeTxt.parent)
            {
               _openTimeTxt.parent.removeChild(_openTimeTxt);
            }
         }
         else
         {
            _btn.visible = false;
            _iconBack.visible = false;
            addChild(_openTxt);
            addChild(_openTimeTxt);
         }
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.worldboss.pvpwarfight.WarFightItemBgAsset");
         addChild(_bg);
         _iconBack = ComponentFactory.Instance.creatComponentByStylename("worldboss.ItemIconBack");
         addChild(_iconBack);
         _iconBack.visible = false;
         _btn = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvp.warfight.ItemButton");
         addChild(_btn);
         _btn.visible = false;
         _icon = ComponentFactory.Instance.creatCustomObject("worldboss.ItemIcon");
         addChild(_icon);
         _mapName = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvp.warfight.MapNameTxt");
         addChild(_mapName);
         _openTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvp.warfight.OpenTimeTxt");
         addChild(_openTxt);
         _openTimeTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvp.warfight.OpenTimeValueTxt");
         addChild(_openTimeTxt);
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvp.warfight.DesTxt");
         addChild(_descTxt);
         _btn.addEventListener("click",__enterWarFightHandler);
      }
      
      private function __enterWarFightHandler(param1:MouseEvent) : void
      {
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("WarField_MaxCount");
         var _loc2_:int = int(_loc4_ ? int(_loc4_.ConfigValue) : 2);
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.warFieldCount);
         if(_loc3_ <= 0)
         {
            SingWarSocketSendManager.sendRequestPvpRemainNumber(campaignId);
            return;
         }
         SingWarSocketSendManager.enterWarfield(campaignId);
      }
      
      override public function dispose() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__enterWarFightHandler);
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_mapName);
         _mapName = null;
         ObjectUtils.disposeObject(_openTxt);
         _openTxt = null;
         ObjectUtils.disposeObject(_openTimeTxt);
         _openTimeTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


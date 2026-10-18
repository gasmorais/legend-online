package forbiddenboss
{
   import battle.utils.Int64Utils;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossMsg;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.forbiddenboss.ForbiddenBossModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ForbiddenBossManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class ForbiddenBossItem extends Component implements IManualSize, ISelectable
   {
      
      private var _bg:Bitmap;
      
      private var _selectedBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _bossTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _refreshTxt:FilterFrameText;
      
      private var _iconImg:ScaleFrameImage;
      
      private var _iconTxt:FilterFrameText;
      
      private var _index:int;
      
      private var _selected:Boolean;
      
      private var _data:ForbiddenBossTempInfo;
      
      public function ForbiddenBossItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
         this.buttonMode = true;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,232,78);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ForbiddenBossItem.bg");
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.ForbiddenBossItem.selectedBg");
         _icon = ComponentFactory.Instance.creatCustomObject("forbiddenBossItem.icon");
         _bossTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossItem.bossTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossItem.levelTxt");
         _refreshTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossItem.refreshTxt");
         _iconImg = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossItem.iconImg");
         _iconTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossItem.iconTxt");
         addChild(_bg);
         addChild(_icon);
         addChild(_bossTxt);
         addChild(_levelTxt);
         addChild(_refreshTxt);
         addChild(_iconImg);
         addChild(_iconTxt);
         addChild(_selectedBg);
         _selectedBg.visible = false;
      }
      
      public function set data(param1:ForbiddenBossTempInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(!_data)
         {
            return;
         }
         _icon.icon = IconFactory.getCommonIconPath(_data.bossIcon);
         _bossTxt.text = _data.bossName;
         _levelTxt.text = LanguageMgr.GetTranslation("public.level2",_data.bossGrades);
         if(_data.BossType > 1)
         {
            _loc2_ = _data.BossType - 1;
            _iconImg.visible = true;
            _iconImg.setFrame(_loc2_);
            _iconTxt.text = LanguageMgr.GetTranslation("forbiddenBossItem.iconTxt.text" + _loc2_);
            _iconTxt.setFrame(_loc2_);
         }
         else
         {
            _iconImg.visible = false;
            _iconTxt.text = "";
         }
         refreshView();
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("FORBIDDEN_BOSS_LIST_UPDATE",this,__updateListHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("FORBIDDEN_BOSS_LIST_UPDATE",this,__updateListHandler);
      }
      
      private function __updateListHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:Date = null;
         var _loc6_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:String = null;
         var _loc9_:Number = NaN;
         var _loc7_:Date = null;
         _loc2_ = null;
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         if(!_data)
         {
            return;
         }
         for each(var _loc3_:ForbiddenBossMsg in model.bossList)
         {
            if(_loc3_.bossId == _data.Id)
            {
               _loc1_ = DateFormatter.parse(_loc3_.refreshTime,"YYYY-MM-DD hh:mm:ss");
               _loc6_ = _loc1_.time;
               _loc4_ = Number(PlayerManager.instance.currentPlayerModel.sysCurtime.time);
               _loc8_ = _loc6_ - _loc4_;
               if(_loc8_ < 5000)
               {
                  _refreshTxt.text = LanguageMgr.GetTranslation("forbiddenBossItem.refreshTxt.text1");
                  _refreshTxt.setFrame(1);
               }
               else
               {
                  _loc2_ = DateFormatter.format(_loc1_,"hh:mm:ss");
                  _refreshTxt.text = LanguageMgr.GetTranslation("forbiddenBossItem.refreshTxt.text2",_loc2_);
                  _refreshTxt.setFrame(2);
               }
               if(_loc3_.state == 0)
               {
                  _icon.filters = [UIFilter.getGrayFilter()];
               }
               else
               {
                  _icon.filters = [];
                  if(_loc3_.endTime && Int64Utils.int64ToNumber(_loc3_.endTime) != 0)
                  {
                     _loc9_ = Number(Int64Utils.int64ToNumber(_loc3_.endTime));
                     _loc7_ = new Date(Int64Utils.int64ToNumber(_loc3_.endTime));
                     _loc2_ = DateFormatter.format(_loc7_,"hh:mm:ss");
                     _loc10_ = _loc9_ / 1000 - playerModel.sysSecond;
                     _loc5_ = _loc10_ / 60;
                     if(_loc10_ > 0)
                     {
                        _refreshTxt.text = LanguageMgr.GetTranslation("forbiddenBossItem.refreshTxt.text3",_loc2_);
                        _refreshTxt.setFrame(2);
                        _refreshTxt.textColor = 16776960;
                     }
                  }
               }
            }
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
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
         _selectedBg.visible = _selected;
      }
      
      private function get model() : ForbiddenBossModel
      {
         return ForbiddenBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_bossTxt);
         _bossTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_refreshTxt);
         _refreshTxt = null;
         ObjectUtils.disposeObject(_iconImg);
         _iconImg = null;
         ObjectUtils.disposeObject(_iconTxt);
         _iconTxt = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}


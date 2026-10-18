package water.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.IManualTipTargetSize;
   import com.pickgliss.utils.ObjectUtils;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.IMManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PlayerTreeExpView extends Component implements Disposeable, IManualTipTargetSize
   {
      
      private var _back:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _playerIcon:BaseIconView;
      
      private var _playerNameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _max:FilterFrameText;
      
      private var _iconMask:Shape;
      
      private var _mask:Shape;
      
      private var _percent:Number;
      
      private var _maskBegin_x:Number;
      
      private var _data:FarmInfo;
      
      public function PlayerTreeExpView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.water.TreeExpBack");
         _progress = ComponentFactory.Instance.creatBitmap("asset.water.TreeExpImg");
         _playerIcon = ComponentFactory.Instance.creatCustomObject("water.PlayerIcon");
         _playerNameTxt = ComponentFactory.Instance.creatComponentByStylename("water.PlayerNameTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("water.WaterLevelTxt");
         _max = ComponentFactory.Instance.creatComponentByStylename("water.TreeExpMaxTxt");
         addChild(_back);
         addChild(_progress);
         addChild(_playerIcon);
         addChild(_playerNameTxt);
         addChild(_levelTxt);
         addChild(_max);
         _iconMask = createIconMask();
         _mask = creatShape();
         addChild(_iconMask);
         addChild(_mask);
         _playerIcon.mask = _iconMask;
         _progress.mask = _mask;
         startPoint = new Point(_max.x,_max.y);
      }
      
      private function createIconMask() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawCircle(32,34,30);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function creatShape() : Shape
      {
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("water.TreeShapeMask");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(86,36,_loc2_.x,_loc2_.y);
         _loc1_.graphics.endFill();
         _loc1_.x = _loc2_.x * -1;
         _maskBegin_x = _loc2_.x * -1;
         return _loc1_;
      }
      
      public function set percent(param1:Number) : void
      {
         _percent = param1;
      }
      
      private function removeFarmListener(param1:FarmInfo) : void
      {
         if(param1)
         {
            param1.removeEventListener("FARM_GP_CHANGE",__gpChanged);
            param1.removeEventListener("FARM_GRADE_CHANGE",__gradeChanged);
         }
      }
      
      private function addFarmListener(param1:FarmInfo) : void
      {
         if(param1)
         {
            param1.addEventListener("FARM_GP_CHANGE",__gpChanged);
            param1.addEventListener("FARM_GRADE_CHANGE",__gradeChanged);
         }
      }
      
      private function __gradeChanged(param1:FarmEvent) : void
      {
         if(_data)
         {
            _levelTxt.text = _data.grade.toString();
            __gpChanged(null);
         }
      }
      
      private function __gpChanged(param1:FarmEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:UpgradeTemplateInfo = null;
         if(_data)
         {
            _loc4_ = getNextGradeTemp(_data.grade + 1,17);
            if(_loc4_)
            {
               _loc3_ = _data.gp / _loc4_.Data;
               if(_loc3_ > 1)
               {
                  _loc3_ = 1;
                  _loc2_ = _loc4_.Data + " / " + _loc4_.Data;
               }
               else
               {
                  _loc2_ = _data.gp + " / " + _loc4_.Data;
               }
            }
            else
            {
               _loc3_ = 1;
               _loc2_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarTip.gp01");
            }
            _max.text = _loc2_;
            _mask.x = _maskBegin_x + _mask.width * _loc3_;
         }
      }
      
      public function set data(param1:FarmInfo) : void
      {
         var _loc2_:ThaneInfo = null;
         removeFarmListener(_data);
         _data = param1;
         addFarmListener(_data);
         if(_data)
         {
            if(_data.userId == thane.userId)
            {
               _playerNameTxt.text = thane.nickName;
               _playerIcon.icon = IconFactory.getPlayerIcon(thane.snsInfo.headId,"head");
            }
            else
            {
               _loc2_ = IMManager.instance.getFriendInfo(_data.userId);
               if(_loc2_)
               {
                  _playerNameTxt.text = _loc2_.nickName;
                  _playerIcon.icon = IconFactory.getPlayerIcon(_loc2_.snsInfo.headId,"head");
               }
               else
               {
                  _playerNameTxt.text = _data.nickName;
               }
            }
            _levelTxt.text = _data.grade.toString();
            __gpChanged(null);
         }
         else
         {
            _max.text = "0/0";
            _playerIcon.icon = null;
            _playerNameTxt.text = "";
            _levelTxt.text = "1";
            _mask.x = _maskBegin_x + _mask.width * 0;
         }
         tipData = LanguageMgr.GetTranslation("buildings.water.view.PlayerTreeExpView.tipData");
      }
      
      private function getNextGradeTemp(param1:int, param2:int) : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(param1,param2);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get manualHeight() : Number
      {
         return 30;
      }
      
      public function get manualWidth() : Number
      {
         return 160;
      }
      
      override public function dispose() : void
      {
         removeFarmListener(_data);
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_iconMask);
         _iconMask = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_playerIcon);
         _playerIcon = null;
         ObjectUtils.disposeObject(_playerNameTxt);
         _playerNameTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_max);
         _max = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


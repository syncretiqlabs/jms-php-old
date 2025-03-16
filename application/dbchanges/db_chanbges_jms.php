2021-1-14
ALTER TABLE `TimeSheet` ADD `ProjectID` INT(11) NOT NULL DEFAULT '0' AFTER `Id`;

ALTER TABLE `TimeSheet` CHANGE `StartTime` `StartTime` TIME NOT NULL;


ALTER TABLE `TimeSheet` CHANGE `FinishTime` `FinishTime` TIME NOT NULL;

ALTER TABLE `TimeSheet` CHANGE `Date` `Date` DATE NOT NULL;
--------------------------------------------------------------------------
1-19

ALTER TABLE `Job` ADD `Status` INT(11) NOT NULL DEFAULT '0' AFTER `JobEndDate`;


ALTER TABLE `TimeSheet` ADD `BreakMin` INT(11) NOT NULL DEFAULT '0' AFTER `Break`;


DROP TABLE IF EXISTS `JobFiles`;
CREATE TABLE `jobfiles` (
  `Id` INT(10) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Path` VARCHAR(200) NOT NULL,
  `ResourceId` INT(10) NOT NULL,
  `JobId` INT(11) DEFAULT NULL,
  `ProjectId` INT(11) DEFAULT NULL,
  `AddedOn` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `AddedBy` INT(5) DEFAULT '0',
  `ModifiedOn` DATETIME DEFAULT NULL,
  `ModifiedBy` INT(5) DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `JobFiles`
--

INSERT INTO `JobFiles` (`Id`, `Name`, `Path`, `ResourceId`, `JobId`, `ProjectId`, `AddedOn`, `AddedBy`, `ModifiedOn`, `ModifiedBy`) VALUES
(2, '1611033925cpu.png', '', 6, 90, 1, '2021-01-25 06:25:25', 6, '2021-01-25 06:25:25', 6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `JobFiles`
--
ALTER TABLE `JobFiles`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `JobFiles`
--
ALTER TABLE `JobFiles`
  MODIFY `Id` INT(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;


